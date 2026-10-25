local M = {}

function M.run(opts)
    if vim.fn.executable("sh") == 0 then
        vim.api.nvim_echo({{"Error: The command 'sh' does not exist in $PATH"}}, false, {err = true})
        return
    end

    local width = vim.o.columns
    local height = vim.o.lines
    local buffer = vim.api.nvim_create_buf(false, true)
    local window = vim.api.nvim_open_win(buffer, true, {
        style = "minimal",
        border = "rounded",
        relative = "editor",

        row = math.ceil(height * 0.1) - 1,
        col = math.ceil(width * 0.15),
        width = math.ceil(width * 0.7),
        height = math.ceil(height * 0.8) - 3,

        title = opts.title and string.format(" %s ", vim.fn.trim(opts.title, " :")),
        title_pos = opts.title and "center",
    })

    vim.b[buffer].completion = false
    vim.bo[buffer].bufhidden = "wipe"
    vim.wo[window].wrap = false
    vim.wo[window].winhighlight = "Normal:Normal,FloatTitle:Title,FloatBorder:WinSeparator"

    local temp_stdin = nil
    local temp_stdout = vim.fn.tempname()

    local cmd = "fzf"
    if opts.multi then
        cmd = cmd.." --multi"
    end

    if opts.flags then
        cmd = cmd.." "..opts.flags
    end
    cmd = cmd.." --reverse --no-scrollbar >"..vim.fn.shellescape(temp_stdout)

    if opts.cmd then
        cmd = opts.cmd.." | "..cmd
    elseif opts.items then
        temp_stdin = vim.fn.tempname()
        vim.fn.writefile(opts.items, temp_stdin)
        cmd = cmd.." <"..vim.fn.shellescape(temp_stdin)
    end

    vim.fn.jobstart({"sh", "-c", cmd}, {
        term = true,
        on_exit = function (_, code)
            vim.api.nvim_buf_delete(buffer, {force = true})
            local output = vim.fn.readfile(temp_stdout)
            os.remove(temp_stdout)

            if temp_stdin then
                os.remove(temp_stdin)
            end

            if code == 0 then
                if opts.accept then
                    if opts.multi then
                        opts.accept(output)
                    else
                        opts.accept(output[1])
                    end
                else
                    for _, file in ipairs(output) do
                        vim.cmd.edit(file)
                    end
                end
            end
        end
    })

    vim.cmd.startinsert()
    vim.api.nvim_create_autocmd("TermLeave", {
        buf = buffer,
        callback = function(ev)
            vim.api.nvim_chan_send(vim.bo[buffer].channel, "\x03")
        end
    })
end

function M.execute()
    local items = {}
    for key in pairs(M) do
        if key ~= "run" and key ~= "execute" then
            table.insert(items, key)
        end
    end

    M.run {
        items = items,
        accept = function (key)
            M[key]()
        end
    }
end

function M.files()
    M.run {
        title = "Files",
        multi = true,
    }
end

function M.git_files()
    vim.fn.system("git rev-parse --is-inside-work-tree >/dev/null 2>/dev/null")
    if vim.v.shell_error == 0 then
        M.run {
            cmd = "git ls-files --cached --others --exclude-standard",
            title = "Git Files",
            multi = true,
        }
    else
        M.run {
            title = "Files",
            multi = true,
        }
    end
end

function M.buffers()
    local cwd = vim.loop.cwd()
    local refs = {}
    local buffers = {}
    local empties = 1

    for _, item in ipairs(vim.fn.getbufinfo({buflisted = true})) do
        local name = item.name
        if name == "" then
            name = "[No Name #"..empties.."]"
            empties = empties + 1
        else
            if name == cwd then
                name = "."
            end

            if not vim.endswith(cwd, "/") then
                cwd = cwd.."/"
            end

            if vim.startswith(name, cwd) then
                name = name:sub(#cwd + 1)
            end

            if vim.startswith(name, vim.env.HOME) then
                name = "~"..name:sub(#vim.env.HOME + 1)
            end
        end

        refs[name] = item.bufnr
        table.insert(buffers, {name, item.lastused})
    end

    local current = vim.api.nvim_get_current_buf()
    for i, buffer in ipairs(buffers) do
        if refs[buffer[1]] == current then
            current = table.remove(buffers, i)
            break
        end
    end

    table.sort(buffers, function (a, b) return a[2] > b[2] end)
    table.insert(buffers, current)

    for i, buffer in ipairs(buffers) do
        buffers[i] = buffer[1]
    end

    M.run {
        items = buffers,
        title = "Buffers",
        accept = function (buffer)
            local n = refs[buffer]
            if n then
                vim.api.nvim_set_current_buf(n)
            end
        end
    }
end

function M.man_pages()
    local complete = require("man").man_complete or vim.fn["man#complete"]
    M.run {
        items = complete("*", "Man *", 5),
        title = "Manpages",
        accept = function (page)
            vim.cmd.Man(page)
        end
    }
end

function M.helptags()
    local langs = {"en"}
    local langs_map = {en = true}
    local tag_files = {}
    local function add_tag_file(lang, file)
        if langs_map[lang] then
            if tag_files[lang] then
                table.insert(tag_files[lang], file)
            else
                tag_files[lang] = {file}
            end
        end
    end

    local function path_tail(path)
        for i = #path, 1, -1 do
            if path:sub(i, i) == "/" then
                return path:sub(i + 1, -1)
            end
        end
        return path
    end

    local help_files = {}
    local all_files = vim.api.nvim_get_runtime_file("doc/*", true)
    for _, fullpath in ipairs(all_files) do
        local file = path_tail(fullpath)
        if file == "tags" then
            add_tag_file("en", fullpath)
        elseif file:match "^tags%-..$" then
            local lang = file:sub(-2)
            add_tag_file(lang, fullpath)
        else
            help_files[file] = fullpath
        end
    end

    local tags = {}
    local tags_map = {}
    local delimiter = string.char(9)
    for _, lang in ipairs(langs) do
        for _, file in ipairs(tag_files[lang] or {}) do
            local lines = vim.fn.readfile(file)
            for _, line in ipairs(lines) do
                if not line:match "^!_TAG_" then
                    local fields = vim.split(line, delimiter, true)
                    if #fields == 3 and not tags_map[fields[1]] then
                        if fields[1] ~= "help-tags" or fields[2] ~= "tags" then
                            table.insert(tags, fields[1])
                            tags_map[fields[1]] = true
                        end
                    end
                end
            end
        end
    end

    M.run {
        items = tags,
        title = "Helptags",
        accept = function (tag)
            vim.cmd.help(tag)
        end
    }
end

function M.rg()
    M.run {
        items = {},
        flags = "--ansi --disabled --bind 'change:reload(rg --column --color=always {q} || true)'",
        title = "Ripgrep",
        accept = function (output)
            local comps = vim.split(output, ":")
            local path = comps[1]
            local row = tonumber(comps[2])
            local col = tonumber(comps[2]) - 1
            vim.cmd.edit(path)
            vim.api.nvim_win_set_cursor(0, {row, col})
        end
    }
end

function vim.ui.select(items, opts, accept)
    opts = opts or {}

    local lookup = {}
    if opts.format_item then
        for i, item in ipairs(items) do
            items[i] = opts.format_item(item)
            lookup[items[i]] = item
        end
    end

    local prompt = opts.prompt
    if prompt then
        prompt = prompt.." "
    end

    M.run {
        items = items,
        title = prompt,
        accept = function (option)
            if opts.format_item then
                option = lookup[option]
            end

            if option then
                accept(option)
            end
        end
    }
end

return M

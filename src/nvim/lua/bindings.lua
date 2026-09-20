vim.keymap.set("n", "H", "<c-u>")
vim.keymap.set("n", "L", "<c-d>")
vim.keymap.set("n", "U", "<c-r>")
vim.keymap.set("n", "Q", ":Ex<cr>")

vim.keymap.set("v", "v", "<esc>")
vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("c", "jk", "<c-c>")
vim.keymap.set("t", "jk", "<c-\\><c-n>")

vim.keymap.set("v", "<leader>r", ":s//gc<left><left><left>")
vim.keymap.set("n", "<leader>r", ":%s//gc<left><left><left>")

vim.keymap.set("n", "<leader>w", "<c-w>")
vim.keymap.set("n", "<leader>s", ":write<cr>")
vim.keymap.set("n", "<leader>d", ":bdelete!<cr>")

vim.keymap.set("n", "<leader>/", function ()
    vim.cmd("echohl Question")
    local ok, query = pcall(vim.fn.input, "Search> ")
    vim.cmd("echohl Normal")

    if ok and query ~= "" then
        if vim.fn.executable("rg") == 1 then
            vim.cmd("Compile rg -i --vimgrep "..vim.fn.shellescape(query))
        else
            vim.cmd("Compile grep -irn "..vim.fn.shellescape(query))
        end
    else
        vim.cmd("mode")
    end
end)

vim.keymap.set("n", "<leader><leader>", vim.fn["literate#source"])

local ido = require("ido")
ido.bind {jk = ido.exit}

vim.keymap.set("n", "<leader>F", ido.browse)
vim.keymap.set("n", "<leader>b", ido.buffers)
vim.keymap.set("n", "<leader>i", ido.execute)
vim.keymap.set("n", "<leader>f", ido.git_files)
vim.keymap.set("n", "<leader>K", ido.man_pages)

local compile = require("compile")
compile.setup {
    bindings = {
        q = vim.cmd.close
    },

    patterns = {
        Jai = "[<path>]:[<row>],[<col>]",
        Odin = "[<path>]([<row>]:[<col>])",
        Rust = "[<path>]:[<row>]:[<col>]",
        Python = 'File "[<path>]", line [<row>]',

        ["cl.exe"] = "[<path>]([<row>])",
    }
}

vim.keymap.set("n", "<leader>h", ":Compile<up>")
vim.keymap.set("n", "<leader>H", ":Compile ")
vim.keymap.set("n", "<leader>j", ":CompileNext<cr>")
vim.keymap.set("n", "<leader>k", ":CompilePrev<cr>")
vim.keymap.set("n", "<leader>J", ":CompileNextSecondary<cr>")

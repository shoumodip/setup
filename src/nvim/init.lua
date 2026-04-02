-- Basic Options
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.clipboard = "unnamedplus"
vim.opt.signcolumn = "no"
vim.opt.cinoptions = ":0,l1"

vim.opt.number = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.relativenumber = true

vim.opt.hlsearch = false
vim.opt.showmode = false
vim.opt.swapfile = false
vim.opt.fillchars = "eob: "
vim.opt.statusline = "%f%m%=%{trim(system('git rev-parse --abbrev-ref HEAD 2>/dev/null'))}"

vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.wildignorecase = true

vim.opt.shortmess:append("I")
vim.opt.timeoutlen = 200

vim.g.mapleader = " "
vim.g.c_syntax_for_h = 1
vim.g.c_no_curly_error = 1

-- Plugins
vim.pack.add {
    "https://github.com/shoumodip/bs.vim",
    "https://github.com/shoumodip/fm.vim",
    "https://github.com/shoumodip/ido.nvim",
    "https://github.com/shoumodip/compile.nvim",
    "https://github.com/shoumodip/vim-literate",
    "https://github.com/sainnhe/gruvbox-material",
    "https://github.com/nvim-treesitter/nvim-treesitter",

    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/williamboman/mason.nvim",
    {src = "https://github.com/saghen/blink.cmp", version = "v1.6.0"},

    "https://github.com/tpope/vim-rsi",
    "https://github.com/tpope/vim-repeat",
    "https://github.com/tpope/vim-fugitive",
    "https://github.com/tpope/vim-surround",
    "https://github.com/tpope/vim-commentary"
}

-- Colorscheme
vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
vim.cmd([[
    colorscheme gruvbox-material
    highlight! NormalFloat guibg=#3a3735
    highlight! link Pmenu NormalFloat
    highlight! link PmenuKind Function
    highlight! link PmenuExtra Comment
]])

-- Basic Keybindings
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

-- Ido
local ido = require("ido")
ido.bind {jk = ido.exit}

vim.keymap.set("n", "<leader>F", ido.browse)
vim.keymap.set("n", "<leader>b", ido.buffers)
vim.keymap.set("n", "<leader>i", ido.execute)
vim.keymap.set("n", "<leader>f", ido.git_files)
vim.keymap.set("n", "<leader>K", ido.man_pages)

-- Compilation Mode
local compile = require("compile")
compile.setup {
    bindings = {
        q = vim.cmd.close
    },

    patterns = {
        Odin = "[<path>]([<row>]:[<col>])",
        Rust = "[<path>]:[<row>]:[<col>]",
        Python = 'File "[<path>]", line [<row>]',
    }
}

vim.keymap.set("n", "<leader>h", ":Compile<up>")
vim.keymap.set("n", "<leader>H", ":Compile ")
vim.keymap.set("n", "<leader>j", ":CompileNext<cr>")
vim.keymap.set("n", "<leader>k", ":CompilePrev<cr>")
vim.keymap.set("n", "<leader>J", ":CompileNextSecondary<cr>")

-- Treesitter
vim.api.nvim_create_autocmd("FileType", {
	callback = function(ev)
		local language = vim.treesitter.language.get_lang(ev.match)
		if vim.treesitter.language.add(language) then
			vim.treesitter.start()
            return
		end

        local treesitter = require("nvim-treesitter")
        local available = treesitter.get_available()
        if vim.tbl_contains(available, language) then
            treesitter.install(language):await(function ()
                if vim.treesitter.language.add(language) then
                    vim.treesitter.start()
                end
            end)
        end
    end
})

vim.keymap.set({"n", "x", "o"}, "<tab>", function()
	if vim.treesitter.get_parser() then
        require("vim.treesitter._select").select_parent(vim.v.count1)
	end
end)

vim.keymap.set({"n", "x", "o"}, "<s-tab>", function()
	if vim.treesitter.get_parser() then
		require("vim.treesitter._select").select_child(vim.v.count1)
	end
end)

-- Programming
local blink = require("blink.cmp")
blink.setup {
    keymap = {
        preset = "enter",
        ["<tab>"] = { "select_next", "fallback" },
        ["<s-tab>"] = { "select_prev", "fallback" },
    },

    completion = {
        documentation = {auto_show = true, auto_show_delay_ms = 50}
    },

    cmdline = {enabled = false}
}

require("mason").setup()
require("nvim-autopairs").setup()

vim.lsp.enable(vim.iter(require("mason-registry").get_installed_packages()):fold({}, function(acc, pack)
	table.insert(acc, pack.spec.neovim and pack.spec.neovim.lspconfig)
	return acc
end))

vim.lsp.config("*", {capabilities = blink.get_lsp_capabilities()})

vim.diagnostic.config {
    virtual_text = true,
    update_in_insert = true
}

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function (e)
        local buffer = e.buf
        local client = vim.lsp.get_client_by_id(e.data.client_id)

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer = buffer})
        vim.keymap.set("i", "<c-y>", vim.lsp.buf.signature_help, {buffer = buffer})
        vim.keymap.set("n", "<leader>n", vim.lsp.buf.rename, {buffer = buffer})
        vim.keymap.set("n", "<leader>l", vim.lsp.buf.references, {buffer = buffer})
        vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, {buffer = buffer})
        vim.keymap.set("n", "<leader>j", vim.diagnostic.goto_next, {buffer = buffer})
        vim.keymap.set("n", "<leader>k", vim.diagnostic.goto_prev, {buffer = buffer})

        if client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_buf_set_var(buffer, "lspformat", true)
        end
    end
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = {"*"},
    callback = function ()
        if pcall(vim.api.nvim_buf_get_var, 0, "lspformat") then
            vim.lsp.buf.format()
        else
            local save = vim.fn.winsaveview()
            vim.cmd("keeppatterns %s/\\s\\+$//e")
            vim.cmd("keeppatterns %s/\\n\\+\\%$//e")
            vim.fn.winrestview(save)
        end
    end
})

vim.keymap.set("n", "<leader>m", ":Mason<cr>")

vim.keymap.set("n", "<leader>g", ":G<cr>")
vim.keymap.set("n", "<leader>p", ":G push origin main<space>")
vim.keymap.set("n", "<leader>u", ":G remote add origin git@github.com:")
vim.keymap.set("n", "<leader>U", ":G remote set-url origin git@github.com:")

-- General Autocomplete
local function pmenu_keymap_set(lhs, rhs)
    local current = vim.fn.maparg(lhs, "i", false, true)
    assert(current.expr ~= 0 and (current.callback or current.rhs))

    vim.keymap.set("i", lhs, function()
        if vim.fn.pumvisible() == 1 then
            return vim.keycode(rhs)
        end

        if current.callback then
            return vim.keycode(current.callback())
        end

        if current.rhs then
            return vim.api.nvim_eval(current.rhs)
        end

        error("Unreachable")
    end, {expr = true, silent = true, replace_keycodes = false})
end

pmenu_keymap_set("<cr>", "<c-y>")
pmenu_keymap_set("<tab>", "<c-n>")
pmenu_keymap_set("<s-tab>", "<c-p>")

-- Basics
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.clipboard = "unnamedplus"
vim.opt.laststatus = 2
vim.opt.signcolumn = "no"
vim.opt.cinoptions = ":0,l1"

vim.opt.number = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.termguicolors = true
vim.opt.relativenumber = true

vim.opt.hlsearch = false
vim.opt.showmode = false
vim.opt.swapfile = false
vim.opt.fillchars = "eob: "
vim.opt.statusline = "%f%m"

vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.wildignorecase = true

vim.opt.shortmess:append("I")
vim.opt.timeoutlen = 200

vim.g.mapleader = " "
vim.g.c_syntax_for_h = 1
vim.g.c_no_curly_error = 1

-- Plugins
local paq_path = vim.fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
local paq_installed = vim.fn.empty(vim.fn.glob(paq_path)) == 0

if not paq_installed then
    print("Installing plugins...")
    vim.fn.system({"git", "clone", "--depth=1", "https://github.com/savq/paq-nvim", paq_path})
    vim.cmd("packadd paq-nvim")
    vim.cmd("autocmd User PaqDoneInstall quit")
end

require("paq") {
    "savq/paq-nvim",
    "shoumodip/bs.vim",
    "shoumodip/fm.vim",
    "shoumodip/ido.nvim",
    "shoumodip/compile.nvim",
    "shoumodip/vim-literate",
    "sainnhe/gruvbox-material",
    "nvim-treesitter/nvim-treesitter",

    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "windwp/nvim-autopairs",
    "neovim/nvim-lspconfig",
    "garymjr/nvim-snippets",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    "tpope/vim-rsi",
    "tpope/vim-repeat",
    "tpope/vim-fugitive",
    "tpope/vim-surround",
    "tpope/vim-commentary",

    "perillo/qbe.vim"
}

if not paq_installed then
    vim.cmd("PaqInstall")
    return
end

-- Colorscheme
vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
vim.cmd("colorscheme gruvbox-material")

-- Keybindings
vim.keymap.set("n", "H", "<c-u>")
vim.keymap.set("n", "L", "<c-d>")
vim.keymap.set("n", "Q", ":Ex<cr>")
vim.keymap.set("n", "U", "<c-r>")

vim.keymap.set("v", "v", "<esc>")
vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("c", "jk", "<c-c>")
vim.keymap.set("t", "jk", "<c-\\><c-n>")

vim.keymap.set("v", "<leader>r", ":s//gc<left><left><left>")
vim.keymap.set("n", "<leader>r", ":%s//gc<left><left><left>")

vim.keymap.set("n", "<leader>g", ":G<cr>")
vim.keymap.set("n", "<leader>p", ":G push origin main<space>")
vim.keymap.set("n", "<leader>u", ":G remote add origin git@github.com:")
vim.keymap.set("n", "<leader>U", ":G remote set-url origin git@github.com:")

vim.keymap.set("n", "<leader>w", "<c-w>")
vim.keymap.set("n", "<leader>s", ":write<cr>")
vim.keymap.set("n", "<leader>d", ":bdelete!<cr>")

vim.keymap.set("n", "<leader>h", ":Compile<up>")
vim.keymap.set("n", "<leader>H", ":Compile ")
vim.keymap.set("n", "<leader>n", ":CompileNext<cr>")
vim.keymap.set("n", "<leader>j", ":CompileNextWithCol<cr>")
vim.keymap.set("n", "<leader>k", ":CompilePrevWithCol<cr>")
vim.keymap.set("n", "<leader>m", ":Mason<cr>")

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

-- Autocommands
vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = {"c", "cpp", "glsl"},
    command = "setlocal commentstring=//%s",
})

vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = {"go"},
    command = "setlocal noexpandtab",
})

vim.api.nvim_create_autocmd({"BufWritePre"}, {
    pattern = {"*"},
    callback = function()
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

-- Treesitter
require("nvim-treesitter.configs").setup {
    indent = {
        enable = true,
        disable = {"c", "cpp", "markdown"}
    },

    highlight = {enable = true},
    auto_install = true,
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<tab>",
            node_incremental = "<tab>",
            node_decremental = "<s-tab>",
        },
    }
}

-- Ido
local ido = require("ido")
ido.bind {jk = ido.exit}

vim.keymap.set("n", "<leader>F", ido.browse)
vim.keymap.set("n", "<leader>b", ido.buffers)
vim.keymap.set("n", "<leader>i", ido.execute)
vim.keymap.set("n", "<leader>f", ido.git_files)
vim.keymap.set("n", "<leader>K", ido.man_pages)

-- Compilation Mode
require("compile").bind {q = vim.cmd.close}

-- Snippets
require("snippets").setup {create_cmp_source = true}

-- LSP
local cmp = require("cmp")
cmp.setup {
    mapping = cmp.mapping.preset.insert {
        ["<cr>"] = cmp.mapping.confirm {select = true},
        ["<c-c>"] = cmp.mapping.close(),
        ["<tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif vim.snippet.active {direction = 1} then
                vim.schedule(function() vim.snippet.jump(1) end)
            else
                fallback()
            end
        end,
        ["<s-tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.snippet.active {direction = -1} then
                vim.schedule(function() vim.snippet.jump(-1) end)
            else
                fallback()
            end
        end
    },
    sources = cmp.config.sources {{name = "nvim_lsp"}, {name = "snippets"}},
}

require("nvim-autopairs").setup {}
cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())

require("mason").setup()

local servers = require("mason-lspconfig").get_installed_servers()
local capabilities = require("cmp_nvim_lsp").default_capabilities()

for _, server in ipairs(servers) do
    require("lspconfig")[server].setup {
        capabilities = capabilities,
        on_attach = function (client, buffer)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer = buffer})
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer = buffer})
            vim.keymap.set("n", "gr", vim.lsp.buf.rename, {buffer = buffer})
            vim.keymap.set("n", "<leader>l", vim.lsp.buf.references, {buffer = buffer})
            vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, {buffer = buffer})
            vim.keymap.set("n", "<leader>j", vim.diagnostic.goto_next, {buffer = buffer})
            vim.keymap.set("n", "<leader>k", vim.diagnostic.goto_prev, {buffer = buffer})

            if client.server_capabilities.documentFormattingProvider then
                vim.api.nvim_buf_set_var(buffer, "lspformat", true)
            end
        end
    }
end

vim.diagnostic.config {
    virtual_text = true,
    update_in_insert = true
}

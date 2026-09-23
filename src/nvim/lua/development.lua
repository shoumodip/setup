vim.api.nvim_create_autocmd("FileType", {
    pattern = {"jai"},
    callback = function ()
        vim.bo.commentstring = "//%s"
        vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
    end
})

vim.filetype.add {
    extension = {jai = "jai"}
}

local compile = require("compile")
compile.setup {
    notify = false,

    bindings = {
        q = function ()
            pcall(vim.cmd.close)
            vim.cmd("mode")
        end
    },

    patterns = {
        Jai    = [[\(\f\+\):\(\d\+\),\(\d\+\)]],
        Odin   = [[\(\f\+\)(\(\d\+\):\(\d\+\))]],
        Python = [[File "\(\f\+\)", line \(\d\+\)]],
        MSVC   = [[\(\f\+\)(\(\d\+\))]],
    },
}

vim.keymap.set("n", "<leader>h", ":Compile<up>")
vim.keymap.set("n", "<leader>H", ":Compile ")
vim.keymap.set("n", "<leader>j", compile.next)
vim.keymap.set("n", "<leader>k", compile.prev)

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
        vim.keymap.set("n", "<leader>j", function () vim.diagnostic.jump {count =  1, float = true} end, {buffer = buffer})
        vim.keymap.set("n", "<leader>k", function () vim.diagnostic.jump {count = -1, float = true} end, {buffer = buffer})

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

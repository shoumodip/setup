vim.g.gruvbox_material_diagnostic_virtual_text = "colored"

vim.cmd([[
    colorscheme gruvbox-material
    highlight link String TSString
    highlight link Delimiter Grey
    highlight ErrorMsg gui=bold
]])

vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight_yank", {clear = true}),
    callback = function()
        vim.hl.on_yank()
    end,
})

vim.opt.statusline = "%f%m%=%{trim(system('git rev-parse --abbrev-ref HEAD 2>/dev/null'))}"

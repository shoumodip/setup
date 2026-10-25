vim.keymap.set("n", "H", "<c-u>")
vim.keymap.set("n", "L", "<c-d>")
vim.keymap.set("n", "U", "<c-r>")

require("oil").setup {}
vim.keymap.set("n", "-", ":Oil<cr>")

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
            vim.cmd("Compile rg -S --vimgrep "..vim.fn.shellescape(query))
        else
            vim.cmd("Compile grep -irn "..vim.fn.shellescape(query))
        end
    else
        vim.cmd("mode")
    end
end)

vim.keymap.set("n", "<leader><leader>", vim.fn["literate#source"])

vim.keymap.set("x", "ga", function()
    require("align").align_to_string {preview = true, regex = true}
end)

local fzf = require("fzf")
vim.keymap.set("n", "<leader>F", fzf.files)
vim.keymap.set("n", "<leader>f", fzf.git_files)
vim.keymap.set("n", "<leader>b", fzf.buffers)
vim.keymap.set("n", "<leader>K", fzf.man_pages)
vim.keymap.set("n", "<leader>i", fzf.execute)

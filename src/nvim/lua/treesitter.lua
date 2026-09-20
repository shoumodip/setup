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

vim.keymap.set({"n", "x", "o"}, "<a-o>", function()
	if vim.treesitter.get_parser() then
        vim.treesitter.select("parent", vim.v.count1)
	end
end)

vim.keymap.set({"n", "x", "o"}, "<a-i>", function()
	if vim.treesitter.get_parser() then
        vim.treesitter.select("child", vim.v.count1)
	end
end)

vim.api.nvim_create_autocmd("User", {
    pattern = "TSUpdate",
    callback = function()
        require("nvim-treesitter.parsers").jai = {
            install_info = {
                url = "https://github.com/constantitus/tree-sitter-jai",
                revision = "2763e5001856ea7b5047e780e8dec95a07072d59",
                queries = "queries",
            },
        }
    end
})

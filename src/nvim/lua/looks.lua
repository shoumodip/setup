vim.g.gruvbox_material_transparent_background = true
vim.g.gruvbox_material_diagnostic_virtual_text = "colored"

vim.cmd([[
    colorscheme gruvbox-material
    highlight! link String TSString
    highlight! link Delimiter Grey
]])

vim.opt.laststatus = 3
vim.opt.statusline = "%{%v:lua.require('looks').statusline()%}"

return {
    statusline = function ()
        local components = {}

        -- Mode
        do
            local modes = {
                ["n"]   = "N",
                ["c"]   = "C",
                ["i"]   = "I",
                ["t"]   = "T",
                ["R"]   = "R",

                ["v"]   = "V",
                ["V"]   = "V",
                ["\22"] = "V",

                ["s"]   = "S",
                ["S"]   = "S",
                ["\19"] = "S"
            }

            table.insert(components, {
                value = modes[vim.fn.mode():sub(1, 1)] or "?",
                style = "WarningMsg"
            })
        end

        -- File Name
        do
            table.insert(components, {
                value = "%f",
                style = vim.bo.modified and "Title" or "DefinitionPreviewTitle"
            })
        end

        -- Git
        do
            local branch = vim.fn.FugitiveStatusline()
            if branch ~= "" then
                table.insert(components, {
                    value = " "..branch:sub(6, -3),
                    style = "MiniTestPass"
                })
            end
        end

        -- Switch to the right
        table.insert(components, {
            value = "%=",
        })

        -- LSP
        do
            local clients = vim.lsp.get_clients({bufnr = 0})
            if #clients ~= 0 then
                local counts = vim.diagnostic.count(0)
                local errors = counts[vim.diagnostic.severity.ERROR] or 0
                local warnings = counts[vim.diagnostic.severity.WARN] or 0

                if errors > 0 then
                    table.insert(components, {
                        value = " "..errors,
                        style = "MiniTestFail"
                    })
                end

                if warnings > 0 then
                    table.insert(components, {
                        value = " "..warnings,
                        style = "WarningMsg"
                    })
                end

                local names = {}
                for _, client in ipairs(clients) do
                    table.insert(names, client.name)
                end

                table.insert(components, {
                    value = table.concat(names, " "),
                    style = "Comment"
                })
            end
        end

        -- Filetype
        do
            table.insert(components, {
                value = vim.bo.filetype,
                style = "ClapMatches4"
            })
        end

        local active = tonumber(vim.g.actual_curwin) == vim.fn.win_getid()
        for i, c in ipairs(components) do
            if not active then
                c.style = "Comment"
            end

            if c.style then
                components[i] = string.format("%%$%s$%s%%$$", c.style, c.value)
            else
                components[i] = c.value
            end
        end

        table.insert(components, "")
        table.insert(components, 1, "")
        return table.concat(components, "  ")
    end
}

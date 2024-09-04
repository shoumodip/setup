local in_git = require("ido").utils.in_git

local snippets = {
    MIT = function ()
        local header = table.concat(
            vim.fn.systemlist("date '+%Y'; git config user.name; git config user.email"),
            " ")

        return string.format([[Copyright %s

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.]], header)
    end,

    ["C Include Guards"] = function ()
        local name = vim.fn.fnamemodify(vim.fn.bufname(), ":t"):upper():sub(1, -3).."_H"

        if in_git() then
            local prefix = vim.fn.fnamemodify(
                vim.fn.systemlist("git rev-parse --show-toplevel")[1],
                ":t")

            name = prefix:upper().."_"..name
        end

        return string.format([[#ifndef %s
#define %s


#endif // %s]], name, name, name)
    end,
}

return function ()
    vim.ui.select(vim.tbl_keys(snippets), {prompt = "Insert: "}, function(choice)
        local snippet = snippets[choice]
        if snippet == nil then
            vim.api.nvim_err_write("snippets: no such snippet exists: "..choice)
            return
        end

        if type(snippet) == "function" then
            snippet = snippet()
        end

        assert(type(snippet) == "string")
        vim.fn.setline(vim.fn.line("."), vim.split(snippet, "\n"))
    end)
end

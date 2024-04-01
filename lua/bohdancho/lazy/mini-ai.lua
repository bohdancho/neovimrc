return {
    "echasnovski/mini.ai",
    version = false,
    opts = {
        custom_textobjects = {
            g = function()
                local from = { line = 1, col = 1 }
                local to = {
                    line = vim.fn.line "$",
                    col = math.max(vim.fn.getline("$"):len(), 1),
                }
                return { from = from, to = to }
            end,
        },
    },
}

return {
    "olivercederborg/poimandres.nvim",
    priority = 1000,
    config = function()
        require("poimandres").setup {}
        local highlight = require("poimandres.utils").highlight

        vim.api.nvim_create_autocmd("BufEnter", {
            callback = function()
                highlight("Identifier", { fg = "#ffffff" })
            end,
        })

        vim.cmd.colorscheme "poimandres"
    end,
}

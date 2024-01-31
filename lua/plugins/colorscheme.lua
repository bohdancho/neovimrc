return {
    "olivercederborg/poimandres.nvim",
    priority = 1000,
    config = function()
        require("poimandres").setup {}
        local highlight = require("poimandres.utils").highlight
        highlight("Identifier", { fg = "#ffffff" })

        vim.cmd.colorscheme "poimandres"
    end,
}

return {
    "olivercederborg/poimandres.nvim",
    priority = 1000,
    config = function()
        local poimandres = require "poimandres"
        local highlight = require("poimandres.utils").highlight
        local palette = require "poimandres.palette"

        poimandres.setup {}

        vim.api.nvim_set_hl(0, "BohdanchoBorder", { bg = "NONE", fg = palette.background1 })

        vim.api.nvim_create_autocmd("BufEnter", {
            callback = function()
                highlight("Identifier", { fg = "#ffffff" })
            end,
        })

        vim.cmd.colorscheme "poimandres"
    end,
}

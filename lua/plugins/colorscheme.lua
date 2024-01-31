return {
    "olivercederborg/poimandres.nvim",
    priority = 1000,
    config = function()
        require("poimandres").setup {}
    end,
    init = function()
        vim.cmd.colorscheme "poimandres"
    end,
}

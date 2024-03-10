return {
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = {
                char = "▏", -- This is a slightly thinner char than the default one, check :help ibl.config.indent.char
            },
            scope = {
                show_start = false,
                show_end = false,
            },
        },
    },
    {
        "nmac427/guess-indent.nvim",
        config = function()
            require("guess-indent").setup {}
        end,
    },
}

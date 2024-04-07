return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    keys = {
        {
            "-",
            function()
                require("oil").open_float()
            end,
            desc = "Open file tree",
        },
    },
    opts = {
        keymaps = {
            ["q"] = "actions.close",
        },
        view_options = {
            show_hidden = false,
        },
    },
}

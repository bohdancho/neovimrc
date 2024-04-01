return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    keys = {
        {
            "-",
            function()
                require("oil").open()
            end,
            desc = "Open file tree",
        },
    },
    opts = { keymaps = {
        ["<C-s>"] = false,
        ["q"] = "actions.close",
    } },
}

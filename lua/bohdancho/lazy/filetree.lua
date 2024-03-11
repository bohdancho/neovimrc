return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        {
            "-",
            function()
                require("oil").open_float()
            end,
            desc = "Open file tree",
        },
    },
    opts = { keymaps = {
        ["<C-s>"] = false,
        ["q"] = "actions.close",
    } },
}

-- return {
-- "stevearc/oil.nvim",
-- dependencies = { "nvim-tree/nvim-web-devicons" },
-- lazy = false,
-- keys = {
--     {
--         "-",
--         function()
--             require("oil").open_float()
--         end,
--         desc = "Open file tree",
--     },
-- },
-- opts = {
--     keymaps = {
--         ["q"] = "actions.close",
--     },
--     view_options = {
--         show_hidden = true,
--     },
-- },
-- }

---@type LazySpec
return {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = { "folke/snacks.nvim", lazy = true },
    keys = {
        {
            "-",
            mode = { "n", "v" },
            "<cmd>Yazi<cr>",
            desc = "Open yazi at the current file",
        },
        {
            -- Open in the current working directory
            "<leader>cw",
            "<cmd>Yazi cwd<cr>",
            desc = "Open the file manager in nvim's working directory",
        },
    },
    ---@type YaziConfig | {}
    opts = {
        -- if you want to open yazi instead of netrw, see below for more info
        open_for_directories = true,
        keymaps = {
            show_help = "<f1>",
        },
    },
    -- 👇 if you use `open_for_directories=true`, this is recommended
    init = function()
        -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
        -- vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
    end,
}

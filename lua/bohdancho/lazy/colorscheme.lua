return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd.colorscheme "tokyonight-night"

        -- TODO: do i need this?
        -- vim.cmd.hi "Comment gui=none"
    end,
}

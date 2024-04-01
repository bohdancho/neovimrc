return {
    {
        "williamboman/mason.nvim",
        opts = {},
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        config = function()
            require("mason-tool-installer").setup {
                -- formatting and diagnostics
                ensure_installed = { { "stylua" }, { "prettierd" }, { "sql-formatter" } },
            }
            vim.cmd "MasonToolsInstall"
        end,
    },
}

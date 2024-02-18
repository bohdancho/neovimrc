return {
    "numToStr/Comment.nvim",
    dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    keys = {
        { "gc", mode = { "n", "v" } },
        { "gb", mode = { "n", "v" } },
        {
            "<C-_>",
            function()
                require("Comment.api").toggle.linewise.current()
            end,
            mode = "n",
            desc = "Toggle comment",
        },
        {
            "<C-_>",
            "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
            mode = "v",
            desc = "Toggle comment",
        },
    },
    config = function()
        require("Comment").setup {
            pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
        }
    end,
}

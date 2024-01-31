local idk = 2
return {
    "numToStr/Comment.nvim",
    lazy = true,
    keys = {
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
        require "Comment"
    end,
}

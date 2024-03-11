-- https://github.com/NvChad/ui/blob/v2.0/lua/nvchad/renamer.lua
-- I took it from NvChad (they took it from Reddit) and tweaked it

-- credits to @Malace : https://www.reddit.com/r/neovim/comments/ql4iuj/rename_hover_including_window_title_and/
-- This is modified version of the above snippet

local function apply(curr, win)
    local newName = vim.trim(vim.fn.getline ".")
    vim.api.nvim_win_close(win, true)

    if #newName > 0 and newName ~= curr then
        local params = vim.lsp.util.make_position_params()
        params.newName = newName

        vim.lsp.buf_request(0, "textDocument/rename", params)
    end
end

return {
    open = function()
        local currName = vim.fn.expand "<cword>"

        local win = require("plenary.popup").create(currName, {
            style = "minimal",
            borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            relative = "cursor",
            borderhighlight = "BohdanchoBorder",
            focusable = true,
            width = 25,
            height = 1,
            line = "cursor+2",
            col = "cursor-1",
        })

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = 0
            vim.keymap.set(mode, l, r, opts)
        end

        map({ "n" }, "<C-c>", "<cmd>q<CR>")
        map({ "n" }, "q", "<cmd>q<CR>")

        map({ "n" }, "<C-s>", function()
            apply(currName, win)
            vim.cmd.stopinsert()
        end)
        map({ "i", "n" }, "<CR>", function()
            apply(currName, win)
            vim.cmd.stopinsert()
        end)
    end,
}

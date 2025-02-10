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

local function getNameUnderCursor()
    local line = vim.api.nvim_get_current_line()
    local col = vim.fn.col "."
    local start_col, end_col = col, col

    while start_col > 0 and line:sub(start_col, start_col):match "[%w$_]" do
        start_col = start_col - 1
    end

    while end_col <= #line and line:sub(end_col, end_col):match "[%w$_]" do
        end_col = end_col + 1
    end

    local identifier = line:sub(start_col + 1, end_col - 1)
    return identifier
end

return {
    open = function()
        vim.print "Renaming..."
        local currName = getNameUnderCursor() -- can't just use <cword> because it doesn't include $

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

        map({ "n" }, "q", "<cmd>q<CR>")
        map({ "i", "n" }, "<CR>", function()
            apply(currName, win)
            vim.cmd.stopinsert()
        end)
    end,
}

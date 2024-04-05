-- disable autocomments on new line
vim.cmd "autocmd BufEnter * set formatoptions-=cro"
vim.cmd "autocmd BufEnter * setlocal formatoptions-=cro"

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_user_command("Cpstuff", function()
    vim.cmd "silent! !git add ."
    vim.cmd "silent! !git commit -m 'doing stuff'"
    vim.cmd "silent! !git push"
end, {
    desc = 'Commit and push all changes with commit name "doing stuff"',
    bang = true,
})

vim.opt.expandtab = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamed"
vim.opt.undofile = true
vim.opt.fillchars = { eob = " " }
vim.opt.splitbelow = true
vim.g.mapleader = " "

-- disable autocomments on new line
vim.cmd "autocmd BufEnter * set formatoptions-=cro"
vim.cmd "autocmd BufEnter * setlocal formatoptions-=cro"

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { import = "plugins" },
    { import = "plugins.language" },
}, {
    change_detection = {
        notify = false,
    },
})

require("mappings").load "general"

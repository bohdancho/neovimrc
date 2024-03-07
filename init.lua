vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.fillchars = { eob = " " }

vim.opt.hlsearch = true
vim.keymap.set('n', '<C-c>', '<cmd>nohlsearch<CR>')

vim.opt.cursorline = true
vim.opt.clipboard = "unnamed,unnamedplus" -- significantly slows down startup
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.splitbelow = true

vim.opt.expandtab = true

-- ignore case unless there is a capital letter
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.g.mapleader = " "

-- disable autocomments on new line
vim.cmd "autocmd BufEnter * set formatoptions-=cro"
vim.cmd "autocmd BufEnter * setlocal formatoptions-=cro"

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

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
    { import = "bohdancho.lazy" },
    { import = "bohdancho.lazy.language" },
}, {
    change_detection = {
        notify = false,
    },
})

require("bohdancho.mappings").load_module "general"

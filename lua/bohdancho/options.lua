vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.fillchars = { eob = " " }
vim.opt.scrolloff = 8

vim.opt.hlsearch = true
vim.keymap.set("n", "<C-c>", "<cmd>nohlsearch<CR>")

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.cursorline = true
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.guicursor = "n-v-c-i:block"

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.expandtab = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- ignore case unless there is a capital letter
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.fillchars = { eob = " " }

vim.opt.hlsearch = true
vim.keymap.set("n", "<C-c>", "<cmd>nohlsearch<CR>")

vim.opt.cursorline = true
vim.opt.clipboard = "unnamed,unnamedplus" -- significantly slows down startup
vim.opt.undofile = true
vim.opt.swapfile = false

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.expandtab = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- ignore case unless there is a capital letter
vim.opt.ignorecase = true
vim.opt.smartcase = true

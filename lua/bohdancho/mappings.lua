vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<leader>q", "<C-w>q")

vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
vim.keymap.set({ "i", "v" }, "<C-s>", "<Esc><cmd>w<CR>", { desc = "Save file" })

-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- empty mode is same as using <cmd> :map
-- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
vim.keymap.set("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = "Move down", expr = true })
vim.keymap.set("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "Move up", expr = true })

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+y$]])
vim.keymap.set({ "n", "v" }, "<leader>p", [["+P]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("v", "p", "P", { desc = "Dont copy replaced text" })
vim.keymap.set("v", "P", "p", { desc = "Do copy replaced text" })
vim.keymap.set("n", "x", '"_x', { noremap = true })

vim.keymap.set("i", "<C-h>", "<Left>", { desc = "Move left" })
vim.keymap.set("i", "<C-l>", "<Right>", { desc = "Move right" })
vim.keymap.set("i", "<C-j>", "<Down>", { desc = "Move down" })
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "Move up" })

vim.keymap.set("t", "<C-x>", vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), { desc = "Escape terminal mode" })

vim.keymap.set("n", "<leader>cwc", "sa'(sa({acn<C-C><C-C>l%i,<Space>", { remap = true, desc = "[C]ode [W]rap with [c]n" })

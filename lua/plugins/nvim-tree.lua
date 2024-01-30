return { "nvim-tree/nvim-tree.lua", init=function()require("nvim-tree").setup() end, keys = {
  {"<C-n>", "<cmd> NvimTreeToggle <CR>", desc = "Toggle nvimtree" }
} }

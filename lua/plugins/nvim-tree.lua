return { "nvim-tree/nvim-tree.lua", lazy = true, 
 config=function()require("nvim-tree").setup() end, 
 keys = {
  {"<C-n>", "<cmd> NvimTreeToggle <CR>", desc = "Toggle nvimtree" }
 }
}

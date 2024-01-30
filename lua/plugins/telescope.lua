return {
  'nvim-telescope/telescope.nvim', tag = '0.1.5',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    {"<leader>ff", "<cmd> Telescope find_files <CR>", desc = "Find files" },
    {"<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", desc = "Find all" },
    {"<leader>fw", "<cmd> Telescope live_grep <CR>", desc = "Live grep" },
    {"<leader>fb", "<cmd> Telescope buffers <CR>", desc = "Find buffers" },
    {"<leader>fh", "<cmd> Telescope help_tags <CR>", desc = "Help page" },
    {"<leader>fz", "<cmd> Telescope current_buffer_fuzzy_find <CR>", desc = "Find in current buffer" },

    -- git
    {"<leader>gc", "<cmd> Telescope git_commits <CR>", desc = "[G]it [c]ommits" },
    {"<leader>gs", "<cmd> Telescope git_status <CR>", desc = "[G]it [s]tatus" },
  }
}

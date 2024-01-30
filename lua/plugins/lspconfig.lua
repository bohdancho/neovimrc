return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "yioneko/nvim-vtsls",
    },
    config = function()
      local lspconfig = require "lspconfig"
      require("lspconfig.configs").vtsls = require("vtsls").lspconfig -- set default server config, optional but recommended

      --local config = require "plugins.configs.lspconfig"
      local config = {on_attach = function()end, capabilities = {}}
      require("mason-lspconfig").setup {
        ensure_installed = { "lua_ls", "vtsls", "emmet_ls", "tailwindcss" },
      }

      lspconfig.lua_ls.setup {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
                [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
              },
              maxPreload = 100000,
              preloadFileSize = 10000,
            },
          },
        },
      }


      lspconfig.vtsls.setup {
        on_attach = config.on_attach,
        capabilities = config.capabilities,
      }

      lspconfig.emmet_ls.setup {
        on_attach = config.on_attach,
        capabilities = config.capabilities,
      }

      lspconfig.tailwindcss.setup {
        on_attach = config.on_attach,
        capabilities = config.capabilities,
        settings = {
          -- add autocomplete in unusual places for classes like cva
          tailwindCSS = { experimental = { classRegex = { { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" } } } }
        },
      }
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    config = function()
      require("mason").setup()
    end,
  },
}

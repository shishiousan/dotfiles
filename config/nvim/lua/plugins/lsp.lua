---@diagnostic disable: missing-fields
return {
  -- {
  --   "jose-elias-alvarez/null-ls.nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  --   dependencies = { "mason.nvim" },
  --   opts = function()
  --     local nls = require("null-ls")
  --     return {
  --       root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
  --       sources = {
  --         nls.builtins.formatting.fish_indent,
  --         nls.builtins.diagnostics.fish,
  --         nls.builtins.formatting.stylua,
  --         nls.builtins.formatting.shfmt,
  --         -- nls.builtins.diagnostics.flake8,
  --       },
  --     }
  --   end,
  -- },
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local configs = {
        outline = {
          win_width = 50,
          auto_preview = false,
        },
      }
      -- print("lspsaga is loaded")
      require("lspsaga").setup(configs)
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      ---@type lspconfig.options
      servers = {
        julials = {
          symbol_cache_download = false,
          on_new_config = function(new_config, _)
            local julia = vim.fn.expand("~/.julia/environments/nvim-lspconfig/bin/julia")
            if require("lspconfig").util.path.is_file(julia) then
              new_config.cmd[1] = julia
            end
            -- new_config.cmd_env = vim.tbl_extend("keep", new_config.cmd_env or {}, {
            --   SYMBOL_SERVER = new_config.symbol_server,
            --   SYMBOL_CACHE_DOWNLOAD = (new_config.symbol_cache_download == false) and "0" or "1",
            -- })
          end,
          settings = {
            julials = {
              -- you can write some settings for julials
            },
          },
        },
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        fortls = function(_, opts)
          opts.cmd = {
            "fortls",
            "--lowercase_intrinsics",
            "--source_dirs",
            os.getenv("EASIFEM_SOURCE_DIR") .. "/easifem/base/src/**",
            os.getenv("EASIFEM_SOURCE_DIR") .. "/easifem/classes/src/**",
            "--hover_signature",
            "--hover_language=fortran",
            "--use_signature_help",
          }
        end,
      },
      -- servers = {
      --   fortls = {
      --     on_attach = function(client, bufnr)
      --       -- your other on_attach code
      --       -- for example, set keymaps here, like
      --       -- vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
      --       -- (see below code block for more details)
      --       local navbuddy = require("nvim-navbuddy")
      --       navbuddy.attach(client, bufnr)
      --     end,
      --   },
      -- },
    },
  },
}

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
          root_dir = function(fname)
            local util = require("lspconfig.util")
            return util.root_pattern("Project.toml")(fname) or util.find_git_ancestor(fname) or util.path.dirname(fname)
          end,
          settings = {
            julials = {
              -- you can write some settings for julials
            },
          },
        },
        lua_ls = {
          on_attach = function(client, _)
            client.server_capabilities.semanticTokensProvider = nil
          end,
        },
        taplo = {},
        texlab = {
          settings = {
            texlab = {
              inlayHints = {
                labelReferences = false,
                labelDefinitions = false,
              },
            },
          },
        },
      },
      setup = {
        fortls = function(_, opts)
          opts.capabilities = require("cmp_nvim_lsp").default_capabilities()
          opts.cmd = {
            "fortls",
            "--lowercase_intrinsics",
            "--source_dirs",
            -- os.getenv("EASIFEM_SOURCE_DIR") .. "/easifem/base/src/**",
            os.getenv("DROPBOX") .. "/easifem/base/src/**",
            os.getenv("DROPBOX") .. "/easifem/classes/src/**",
            os.getenv("DROPBOX") .. "/easifem/elasticity/src/**",
            os.getenv("DROPBOX") .. "/easifem/acoustic/src/**",
            os.getenv("HOME") .. "/.easifem/src/tomlf/src/**",
            "--hover_signature",
            "--hover_language=fortran",
            "--use_signature_help",
            -- "--debug_log",
          }
        end,
      },
    },
  },
}

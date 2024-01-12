return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = {
          settings = {
            marksman = {},
          },
        },
      },
    },
  },
  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    ft = { "markdown" },
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup({
        app = "webview",
        -- app = { "brave", "--new-window" },
      })
      -- refer to `configuration to change defaults`
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },
  {
    "arminveres/md-pdf.nvim",
    branch = "main", -- you can assume that main is somewhat stable until releases will be made
    lazy = true,
    config = function()
      require("md-pdf").setup({
        margins = "1.0cm",
        highlight = "tango",
        toc = false,
      })
    end,
    keys = {
      {
        "<leader>mc",
        function()
          require("md-pdf").convert_md_to_pdf()
        end,
        desc = "Convert to pdf",
      },
    },
    opts = {},
  },
  -- {
  --   "iamcco/markdown-preview.nvim",
  --   lazy = true,
  --   ft = { "markdown" },
  --   -- build = "cd app && npm install",
  --   config = function()
  --     vim.g.mkdp_filetypes = { "markdown" }
  --     vim.g.mkdp_auto_start = 0
  --     vim.g.mkdp_auto_close = 1
  --     vim.g.mkdp_refresh_slow = 0
  --     vim.g.mkdp_command_for_global = 0
  --     vim.g.mkdp_open_to_the_world = 0
  --     vim.g.mkdp_open_ip = ""
  --     -- vim.g.mkdp_browser = "/usr/bin/palemoon"
  --     vim.g.mkdp_browser = ""
  --     vim.g.mkdp_echo_preview_url = 0
  --     -- vim.g.mkdp_browserfunc = ""
  --     vim.cmd([[
  --     function CustomMDPreview (url)
  --     execute "silent ! brave --new-window --app=" . a:url
  --     endfunction
  --     ]])
  --     vim.g.mkdp_browserfunc = "CustomMDPreview"
  --     vim.g.mkdp_theme = "dark"
  --   end,
  -- },
}

return {
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  {
    -- "baliestri/aura-theme",
    "daltonmenezes/aura-theme",
    lazy = false,
    priority = 1000,
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
      vim.cmd([[colorscheme aura-dark]])
    end,
  },
  -- {
  --   "bignimbus/pop-punk.vim",
  --   lazy = false,
  --   priority = 1000,
  -- },
  -- {
  --   "LunarVim/lunar.nvim",
  --   lazy = false,
  --   priority = 1000,
  -- },
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "aura-dark",
  --   },
  -- },
  {
    "akinsho/bufferline.nvim",
    optional = true,
    opts = {
      options = {
        -- indicator = {
        --   style = "underline",
        -- },
        -- separator_style = "slant",
      },
    },
    keys = {
      {
        "<leader>bL",
        "<cmd>BufferLineCloseLeft<CR>",
        mode = { "n" },
        silent = false,
        desc = "Delete buffers to the left",
      },
      {
        "<leader>bR",
        "<cmd>BufferLineCloseRight<CR>",
        mode = { "n" },
        silent = false,
        desc = "Delete buffers to the right",
      },
      {
        "<leader>bp",
        "<cmd>BufferLineMovePrev<CR>",
        mode = { "n" },
        silent = false,
        desc = "Move buffer to previous ",
      },
      {
        "<leader>bn",
        "<cmd>BufferLineMoveNext<CR>",
        mode = { "n" },
        silent = false,
        desc = "Move buffer to next ",
      },
      {
        "<leader>bP",
        "<cmd>BufferLineTogglePin<CR>",
        mode = { "n" },
        silent = false,
        desc = " Toggle Pin for buffer ",
      },
      {
        "<leader>bC",
        "<cmd>BufferLineGroupClose ungrouped<CR>",
        mode = { "n" },
        silent = false,
        desc = " Delete all non-pinned buffer ",
      },
      {
        "<leader>bt",
        function()
          local val = vim.o.showtabline
          if val == 0 then
            vim.print("Enabling the bufferline")
            vim.cmd("set showtabline=2")
          else
            vim.print("Disabling the bufferline")
            vim.cmd("set showtabline=0")
          end
        end,
        mode = { "n" },
        desc = " Toggle bufferline",
      },
    },
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    config = function()
      require("nvim-web-devicons").setup({
        override_by_filename = {
          ["toml"] = {
            icon = "",
            color = "#6d8086",
            name = "Toml",
          },
        },
      })
    end,
  },
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local logo = [[
                                                          ⠀⠀⠀⠀⠀⠀⣀⡤⠴⠒⠒⠒⠶⢤⣄⡀⠀⠀⠀⠀⠀⠀
██████╗ ███████╗███╗   ██╗ ██████╗ ██╗   ██╗██╗███╗   ███╗⠀⠀⠀⠀⣠⠞⠁⠀⠀⠀⠀⠀⠀⠀⠈⠙⢦⡀⠀⠀⠀⠀
██╔══██╗██╔════╝████╗  ██║██╔════╝ ██║   ██║██║████╗ ████║⠀⠀⠀⡼⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢳⡀⠀< FXXK YOU!!⠀⠀
██████╔╝█████╗  ██╔██╗ ██║██║  ███╗██║   ██║██║██╔████╔██║⠀⠀⢸⠁⠀⠀⣠⠖⠛⠛⠲⢤⠀⠀⠀⣰⠚⠛⢷⠀⠀⠀
██╔═══╝ ██╔══╝  ██║╚██╗██║██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║⠀⠀⣿⠀⠀⣸⠃⠀⠀⢀⣀⠈⢧⣠⣤⣯⢠⣤⠘⣆⠀⠀
██║     ███████╗██║ ╚████║╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║⠀⠀⣿⠀⠀⡇⠀⠀⠀⠻⠟⠠⣏⣀⣀⣨⡇⠉⢀⣿⠀⠀
╚═╝     ╚══════╝╚═╝  ╚═══╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝⠀⢀⡟⠀⠀⠹⡄⠀⠀⠀⠀⠀⠉⠑⠚⠉⠀⣠⡞⢿⠀⠀
                                                          ⢀⡼⠁⠀⠀⠀⠙⠳⢤⡄⠀⠀⠀⠀⠀⠀⠀⠁⠙⢦⠳⣄
]]

      dashboard.section.header.val = vim.split(logo, "\n")
      dashboard.section.buttons.val = {
        dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
        dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
        dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
        dashboard.button("s", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
        dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
        dashboard.button("q", " " .. " Quit", ":qa<CR>"),
      }
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.section.footer.opts.hl = "AlphaFooter"
      dashboard.opts.layout[1].val = 8
      return dashboard
    end,
  },
}

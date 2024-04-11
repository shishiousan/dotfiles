return {
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  {
    -- "baliestri/aura-theme",
    "shishiousan/aura-theme",
    branch = "dev",
    lazy = false,
    priority = 1000,
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
      vim.cmd([[colorscheme aura-dark]])
    end,
  },
  {
    "LunarVim/lunar.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "akinsho/bufferline.nvim",
    optional = true,
    opts = {
      options = {
        -- mode = "tabs",
        -- always_show_bufferline = false,
        -- custom_filter = function(buf_number, buf_numbers)
        -- filter out filetypes you don't want to see
        -- if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
        --   return true
        -- end
        -- return false -- defautly disable bufferline
        -- end,
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
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function()
      local logo = [[
                                                          ⠀⠀⠀⠀⠀⠀⣀⡤⠴⠒⠒⠒⠶⢤⣄⡀⠀⠀⠀⠀⠀⠀          
██████╗ ███████╗███╗   ██╗ ██████╗ ██╗   ██╗██╗███╗   ███╗⠀⠀⠀⠀⣠⠞⠁⠀⠀⠀⠀⠀⠀⠀⠈⠙⢦⡀⠀⠀⠀⠀          
██╔══██╗██╔════╝████╗  ██║██╔════╝ ██║   ██║██║████╗ ████║⠀⠀⠀⡼⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢳⡀⠀< FXXK YOU!!
██████╔╝█████╗  ██╔██╗ ██║██║  ███╗██║   ██║██║██╔████╔██║⠀⠀⢸⠁⠀⠀⣠⠖⠛⠛⠲⢤⠀⠀⠀⣰⠚⠛⢷⠀⠀⠀          
██╔═══╝ ██╔══╝  ██║╚██╗██║██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║⠀⠀⣿⠀⠀⣸⠃⠀⠀⢀⣀⠈⢧⣠⣤⣯⢠⣤⠘⣆⠀⠀          
██║     ███████╗██║ ╚████║╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║⠀⠀⣿⠀⠀⡇⠀⠀⠀⠻⠟⠠⣏⣀⣀⣨⡇⠉⢀⣿⠀⠀          
╚═╝     ╚══════╝╚═╝  ╚═══╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝⠀⢀⡟⠀⠀⠹⡄⠀⠀⠀⠀⠀⠉⠑⠚⠉⠀⣠⡞⢿⠀⠀          
                                                          ⢀⡼⠁⠀⠀⠀⠙⠳⢤⡄⠀⠀⠀⠀⠀⠀⠀⠁⠙⢦⠳⣄          
    ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"

      local opts = {
        theme = "doom",
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        config = {
          header = vim.split(logo, "\n"),
        -- stylua: ignore
        center = {
          { action = LazyVim.telescope("files"),                                    desc = " Find File",       icon = " ", key = "f" },
          { action = "ene | startinsert",                                        desc = " New File",        icon = " ", key = "n" },
          { action = "Telescope oldfiles",                                       desc = " Recent Files",    icon = " ", key = "r" },
          { action = "Telescope live_grep",                                      desc = " Find Text",       icon = " ", key = "g" },
          { action = [[lua LazyVim.telescope.config_files()()]], desc = " Config",          icon = " ", key = "c" },
          { action = 'lua require("persistence").load()',                        desc = " Restore Session", icon = " ", key = "s" },
          { action = "LazyExtras",                                               desc = " Lazy Extras",     icon = " ", key = "x" },
          { action = "Lazy",                                                     desc = " Lazy",            icon = "󰒲 ", key = "l" },
          { action = "qa",                                                       desc = " Quit",            icon = " ", key = "q" },
        },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "DashboardLoaded",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      return opts
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    keys = {
      {
        "<leader>hs",
        function()
          local lualine = require("lualine")
          local stat = vim.g.statStatusLine
          if stat == nil or stat == true then
            vim.g.statStatusLine = false
            vim.cmd([[set laststatus=0]])
            vim.cmd([[hi! link StatusLine Normal]])
            vim.cmd([[hi! link StatusLineNC Normal]])
            vim.cmd([[set statusline=%{repeat('─',winwidth('.'))}]])
          else
            vim.g.statStatusLine = true
          end
          lualine.hide({ unhide = vim.g.statStatusLine })
        end,
        mode = { "n" },
        desc = "toggle status line",
      },
    },
  },
}

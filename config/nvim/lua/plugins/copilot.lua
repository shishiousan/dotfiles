return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      -- { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "github/copilot.vim" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    opts = {
      debug = true, -- Enable debugging
      -- See Configuration section for rest
      window = {
        layout = "float", -- 'vertical', 'horizontal', 'float', 'replace'
        width = 0.5, -- fractional width of parent, or absolute width in columns when > 1
        height = 0.5, -- fractional height of parent, or absolute height in rows when > 1
        -- Options below only apply to floating windows
        relative = "editor", -- 'editor', 'win', 'cursor', 'mouse'
        border = "rounded", -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
        row = nil, -- row position of the window, default is centered
        col = nil, -- column position of the window, default is centered
        title = "Copilot Chick", -- title of chat window
        footer = nil, -- footer of chat window
        zindex = 1, -- determines if window is on top or below other floating windows
      },
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
  {
    "github/copilot.vim",
    lazy = false,
    config = function()
      vim.keymap.set("i", "<C-CR>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        silent = true,
        replace_keycodes = false,
      })

      vim.keymap.set("i", "<C-tab>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        silent = true,
        replace_keycodes = false,
      })

      -- to cooperate with nvim-cmp
      vim.g.copilot_no_tab_map = true

      -- TODO: translate this into lua ver
      vim.cmd([[ 
      let g:copilot_filetypes = {
          \ '*': v:false, 
          \ 'fortran': v:false, 
          \ 'julia': v:false, 
          \ 'lua': v:false, 
          \ 'go': v:false, 
          \}
      ]])

      -- vim.g.copilot_filetypes = {
      --   fortran = false,
      -- }
      -- vim.keymap.set("i", "<C-L>", "<Plug>(copilot-accept-word)")
      --vim.keymap.set("i", "<M-/>", "<Plug>(copilot-suggest)")
    end,
    keys = {
      {
        "<leader>CC",
        function()
          local stat = vim.g.copilot_enabled
          if stat == nil or stat == 1 then
            vim.cmd([[Copilot disable]])
            vim.notify("Copilot disabled")
          elseif stat == 0 then
            vim.cmd([[Copilot enable]])
            vim.notify("Copilot enabled")
          else
            vim.notify("Failed to toggle Copilot", 4)
          end
        end,
        mode = { "n" },
        desc = "Toggle copilot",
        -- NOTE: this key overwrite default key for codelens
      },
      {
        "<C-S-CR>",
        function()
          vim.cmd([[Copilot panel]])
        end,
        mode = { "i" },
        desc = "Open copilot panel",
      },
      {
        "<leader>CB",
        function()
          local lang = vim.bo.filetype
          -- local stats = vim.b.copilot_enabled
          vim.cmd("let b:copilot_enabled = {'" .. lang .. "': v:true }")
          print("Copilot enabled locally for " .. lang)
        end,
      },
    },
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    opts = {
      provider = "copilot",
      -- add any opts here
    },
    build = ":AvanteBuild", -- This is optional, recommended tho. Also note that this will block the startup for a bit since we are compiling bindings in Rust.
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to setup it properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}

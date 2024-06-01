return {
  {
    "smoka7/multicursors.nvim",
    -- branch = "v0.9.0",
    event = "VeryLazy",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "smoka7/hydra.nvim",
    },
    opts = {},
    cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
    keys = {
      {
        "<C-d>",
        "<cmd>MCstart<cr>",
        desc = "Multi cursor starts",
        mode = { "n", "v" },
      },
    },
  },
  {
    "RRethy/vim-illuminate",
    event = "LazyFile",
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
      end

      map("]]", "next")
      map("[[", "prev")

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
    keys = {
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Prev Reference" },
    },
  },
  {
    "anuvyklack/pretty-fold.nvim",
    config = function()
      require("pretty-fold").setup({
        sections = {
          left = {
            "content",
          },
          right = {
            " ",
            "number_of_folded_lines",
            ": ",
            "percentage",
            " ",
            function(config)
              return config.fill_char:rep(3)
            end,
          },
        },
        fill_char = "•",
        remove_fold_markers = true,
        keep_indentation = true,
        -- Possible values:
        -- "delete" : Delete all comment signs from the fold string.
        -- "spaces" : Replace all comment signs with equal number of spaces.
        -- false    : Do nothing with comment signs.
        process_comment_signs = "spaces",
        comment_signs = {},
        add_close_pattern = true, -- true, 'last_line' or false
        matchup_patterns = {
          { "{", "}" },
          { "%(", ")" }, -- % to escape lua pattern char
          { "%[", "]" }, -- % to escape lua pattern char
        },
        ft_ignore = { "neorg", "TelescopeResults", "ToggleTerm", "Noice", "sagaoutline", "dashboard" },
      })
      require("pretty-fold").ft_setup("lua", {
        matchup_patterns = {
          { "^%s*if", "end" }, -- if ... end
          { "^%s*for", "end" }, -- for
          { "function%s*%(", "end" }, -- 'function( or 'function (''
          { "{", "}" },
          { "%(", ")" }, -- % to escape lua pattern char
          { "%[", "]" }, -- % to escape lua pattern char
        },
      })
    end,
  },
  {
    "anuvyklack/fold-preview.nvim",
    dependencies = "anuvyklack/keymap-amend.nvim",
    config = function()
      local fp = require("fold-preview")
      local map = require("fold-preview").mapping
      local keymap = vim.keymap
      keymap.amend = require("keymap-amend")

      fp.setup({
        auto = false,
        default_keybindings = true,
        border = "single",
      })
    end,
  },
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {
      enabled = false,
    },
  },
  {
    "tris203/precognition.nvim",
    --event = "VeryLazy",
    config = {
      startVisible = false,
      -- showBlankVirtLine = true,
      -- highlightColor = { link = "Comment" },
      -- hints = {
      --      Caret = { text = "^", prio = 2 },
      --      Dollar = { text = "$", prio = 1 },
      --      MatchingPair = { text = "%", prio = 5 },
      --      Zero = { text = "0", prio = 1 },
      --      w = { text = "w", prio = 10 },
      --      b = { text = "b", prio = 9 },
      --      e = { text = "e", prio = 8 },
      --      W = { text = "W", prio = 7 },
      --      B = { text = "B", prio = 6 },
      --      E = { text = "E", prio = 5 },
      -- },
      -- gutterHints = {
      --     -- prio is not currently used for gutter hints
      --     G = { text = "G", prio = 1 },
      --     gg = { text = "gg", prio = 1 },
      --     PrevParagraph = { text = "{", prio = 1 },
      --     NextParagraph = { text = "}", prio = 1 },
      -- },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    ---@type Flash.Config
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          vim.cmd("ccl")
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          vim.cmd("ccl")
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    config = function()
      require("bqf").setup({
        filter = {
          fzf = {
            extra_opts = { "--bind", "ctrl-o:toggle-all", "--delimiter", "│" },
          },
        },
      })
    end,
  },
  {
    "folke/trouble.nvim",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
      {
        "<leader>cS",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP references/definitions/... (Trouble)",
      },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").prev({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous Trouble/Quickfix Item",
      },
    },
  },
  -- {
  --   "onsails/diaglist.nvim",
  -- },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    opts = {
      enable_autocmd = false,
    },
  },
}

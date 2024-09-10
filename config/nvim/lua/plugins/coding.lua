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
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "gsa",
        delete = "gsd",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        replace = "gsr",
        update_n_lines = "gsn",
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
  -- {
  --   "MunifTanjim/nui.nvim",
  --   lazy = true,
  -- },
  {
    "Aasim-A/scrollEOF.nvim",
    event = { "CursorMoved", "WinScrolled" },
    opts = {
      pattern = "*",
      insert_mode = true,
      floating = false,
      disabled_filetypes = {},
      disabled_modes = {},
    },
    config = function(opts)
      require("scrollEOF").setup(opts)
    end,
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    config = function()
      require("tiny-inline-diagnostic").setup({
        signs = {
          left = "",
          right = "",
          diag = "●",
          arrow = "    ",
          up_arrow = "    ",
          vertical = " │",
          vertical_end = " └",
        },
        hi = {
          error = "DiagnosticError",
          warn = "DiagnosticWarn",
          info = "DiagnosticInfo",
          hint = "DiagnosticHint",
          arrow = "NonText",
          background = "CursorLine",
          mixing_color = "None",
        },
        blend = {
          factor = 0.27,
        },
        options = {
          softwrap = 15,
          overflow = {
            mode = "wrap",
          },
          break_line = {
            enabled = false,
            after = 30,
          },
        },
      })
    end,
  },
  {
    "chrisbra/NrrwRgn",
  },
  {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup({
        dimming = {
          alpha = 0.25,
          color = { "Normal", "#ffffff" },
          term_bg = "#000000",
          inactive = false,
        },
        context = 20,
        treesitter = true,
        expand = {
          "subroutine",
          "interface",
          "function",
          "method",
          "table",
          "if_statement",
        },
        exclude = {},
      })
    end,
  },
  { "echasnovski/mini.icons", version = false },
  {
    [1] = "gregorias/toggle.nvim",
    version = "1.0",
    config = true,
  },
  { "lukas-reineke/indent-blankline.nvim", enabled = false },
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup({
        chunk = {
          enable = true,
          chars = {
            horizontal_line = "─",
            vertical_line = "│",
            left_top = "┌",
            left_bottom = "└",
            right_arrow = "─",
          },
          style = {
            "#00ffff",
            "#c21f30",
          },
          exclude_filetypes = {
            toml = true,
          },
        },
        indent = {
          enable = false,
        },
        line_num = {
          enable = true,
          style = "#b30eec",
          use_treesitter = true,
          exclude_filetypes = {
            toml = true,
          },
        },
      })
    end,
  },
  {
    "ojroques/nvim-bufdel",
  },
  -- {
  --   "theRealCarneiro/hyprland-vim-syntax",
  --   dependencies = { "nvim-treesitter/nvim-treesitter" },
  --   ft = "hypr",
  -- },
  { "vim-denops/denops.vim" },
  {
    "vim-skk/skkeleton",
    dependencies = { "vim-denops/denops.vim", "Shougo/ddc.vim" },
    config = function()
      vim.cmd([[ call skkeleton#config({
        \ 'globalDictionaries': ['~/.skkdict/SKK-JISYO.L'],
        \ 'eggLikeNewline': v:true,
        \ })]])
      vim.cmd([[ call skkeleton#register_kanatable('rom', {
          \   ',': ['，', ''],
          \   '.': ['．', ''],
          \ })]])
      -- vim.cmd([[ call ddc#custom#patch_global( 'sources', ['skkeleton'])]])
      -- vim.cmd([[ call ddc#custom#patch_global( 'sourceOptions', {
      -- \ '_': {
      -- \ 'matchers': ['matcher_head'],
      -- \ 'sorters': ['sorter_rank'],
      -- \ },
      -- \ 'skkeleton' : {
      -- \ 'mark': 'skkeleton',
      -- \ 'matchers': [],
      -- \ 'sorters': [],
      -- \ 'converters': [],
      -- \ 'isVolatile': v:true,
      -- \ 'minAutoCompleteLength': 1
      -- \ }})]])
      -- vim.cmd([[call ddc#enable()]])
      -- vim.cmd([[ call ddc#custom#patch_global('ui', 'pum')]])
      vim.keymap.set({ "i", "c" }, [[<C-j>]], [[<Plug>(skkeleton-toggle)]], { noremap = false })
    end,
  },
  {
    "tzachar/highlight-undo.nvim",
    config = function()
      require("highlight-undo").setup({
        duration = 300,
        undo = {
          hlgroup = "HighlightUndo",
          mode = "n",
          lhs = "u",
          map = "undo",
          opts = {},
        },
        redo = {
          hlgroup = "HighlightRedo",
          mode = "n",
          lhs = "<C-r>",
          map = "redo",
          opts = {},
        },
        highlight_for_count = true,
      })
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  },
  -- {
  -- "jinh0/eyeliner.nvim",
  -- config = function()
  --   require("eyeliner").setup({
  --     -- show highlights only after keypress
  --     highlight_on_key = true,
  --     dim = false,
  --     max_length = 9999,
  --     disabled_filetypes = {},
  --     -- e.g., disabled_buftypes = {"nofile"}
  --     disabled_buftypes = {},
  --     default_keymaps = true,
  --   })
  -- end,
  -- },
  {
    "mfussenegger/nvim-lint",
    config = function()
      vim.notify("Loading fortran linting", 3, { title = "LazyVim" })
      local lint = require("lint")

      local errorformat =
        "%-Ggfortran%.%#,%A%f:%l:%c:,%A%f:%l:,%C,%C%p%*[0123456789^],%Z%trror:\\ %m,,%Z%tarning:\\ %m,%C%.%#,%-G%.%#"
      lint.linters.gfortran = {
        name = "gfortran",
        cmd = "gfortran",
        args = {
          "-c",
          "-fsyntax-only",
          "-cpp",
          -- "-fdiagnostics-plain-output",
          "-Wunused-variable",
          "-Wunused-dummy-argument",
          "-Wall",
          "-I",
          os.getenv("HOME") .. "/.easifem/easifem/lint/include/",
          "-I",
          -- os.getenv("HOME") .. "/.easifem/install/arpack/include/arpack/",
          os.getenv("HOME") .. "/.easifem/install/base/include/",
          "-I",
          os.getenv("HOME") .. "/.easifem/install/classes/include/",
          -- os.getenv("HOME") .. "/.easifem/install/fftw/include/",
          -- os.getenv("HOME") .. "/.easifem/install/gmsh/include/",
          -- os.getenv("HOME") .. "/.easifem/install/lapack95/include/",
          -- os.getenv("HOME") .. "/.easifem/install/lis/include/",
          -- os.getenv("HOME") .. "/.easifem/install/sparsekit/include/",
          -- os.getenv("HOME") .. "/.easifem/install/superlu/include/",
          "-I",
          os.getenv("HOME") .. "/.easifem/install/kernels/include/",
          "-I",
          os.getenv("HOME") .. "/.easifem/install/tomlf/include/toml-f/modules/",
          "-J",
          os.getenv("HOME") .. "/.easifem/lint/include/",
          "-DDEBUG_VER",
        }, -- args to pass to the linter
        ignore_exitcode = true, -- set this to true if you don't want to show error messages
        stream = "both", -- set this to "stdout" if the output is not an error, for example with luac
        parser = require("lint.parser").from_errorformat(errorformat),
      }
      lint.linters_by_ft = { fortran = { "gfortran" } }
    end,
  },
  -- add this to the file where you setup your other plugins:
  {
    "monkoose/neocodeium",
    event = "VeryLazy",
    config = function()
      local neocodeium = require("neocodeium")
      neocodeium.setup()
      vim.keymap.set("i", "<A-f>", neocodeium.accept)
    end,
  },
  {
    "OXY2DEV/helpview.nvim",
    lazy = false, -- Recommended

    -- In case you still want to lazy load
    -- ft = "help",

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {
      default = {
        extension = { "png", "svg", "pdf", "eps" },
      },
      -- add options here
      -- or leave it empty to use the default settings
    },
    keys = {
      -- suggested keymap
      { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
  },
}

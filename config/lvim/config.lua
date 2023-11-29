-- Default config.lua exits in https://gist.github.com/pythoninthegrass/4331c9be741760e07fd9d37f25a88f80
-- Default keymappings are shown in https://github.com/abzcoding/lvim/blob/main/lua/user/keybindings.lua#L330

--{{{ [GENERAL]

--
--Levels by name: "trace", "debug", "info", "warn", "error", "off"
--You can set the degree of detail
--
lvim.log.level = "warn"

--
-- Sometimes format on save does not works well for some filetypes
-- Below is the user specific setting
--
lvim.format_on_save = false                           -- turn off the default format on save
vim.api.nvim_create_augroup("lsp_format_on_save", {}) -- make new automatic command group
vim.api.nvim_create_autocmd("BufWritePre", {          -- make new automatic command
  group = "lsp_format_on_save",
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "julia" then
      -- NOTE: don't format julia files
      return
    end
    require("lvim.lsp.utils").format { timeout_ms = 2000, filter = require("lvim.lsp.utils").format_filter }
  end,
})

--
-- You can check other colorschemes by "<leader>sc"
-- My favorite colorschemes are listed
-- High contrast type
-- "abstract", "industry", "lunar", "meta5", "onedark"
-- Low contrast type
-- "dracula", "gruvbox", "habamax", "hybrid", "oceanic_material"
--
lvim.colorscheme = "lunar"

--
-- Please check your terminal transparent setting also if you want transparent editor
--
lvim.transparent_window = false
-- lvim.use_icons = true --I do not know what it does

--
-- Other appearance related config
--
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
-- Note using neo-tree
lvim.builtin.nvimtree.active = false
-- lvim.builtin.nvimtree.setup.view.side = "left"
-- lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

--
-- Toggle terminal setting
-- You can open and close the toggle terminal <C-t>
--
lvim.builtin.terminal.active = true
lvim.builtin.terminal.open_mapping = "<C-t>"
lvim.builtin.terminal.size = 60
lvim.builtin.terminal.direction = "vertical"
-- }}}

-- {{{ [KEYMAPPINGS]
-- View all the defaults by pressing <leader>Lk
-- <C> : Ctrl, <S> : Shift, <CR> : Clear[Enter], <cmd> : ":" [go to command mode]
-- If you want to unmap a default mapping, use "vim.keymap.del("MODE", "KEY")"

-- {{{ [[MAPPING FOR EACH MODE]]
--
-- Insert mode
--
lvim.keys.insert_mode["jj"] = "<esc>"

--
-- Normal mode
--
lvim.leader = "space"                                  -- change leader to space
lvim.keys.normal_mode["<C-s>"] = ":w<CR>"              -- quick file save
lvim.keys.normal_mode["<C-n>"] = "<cmd>nohlsearch<CR>" -- remove highlight
lvim.keys.normal_mode["<leader>v"] = "yyp"             -- copy current line and paste at below
lvim.keys.normal_mode["<leader>V"] = "yyP"             -- copy current line and paste at above

--
-- Visual mode
-- [v is characterwise V is linewise]
--
lvim.keys.visual_mode["<Tab>"] = "<esc>"
lvim.keys.visual_mode["<leader>v"] = "Yp" -- copy the selected area and paste it at its below
lvim.keys.visual_mode["<leader>V"] = "YP" -- copy the selected area and paste it at its above
--}}}

-- {{{ [[WHICH KEY MAPPING]]
--
-- Remove some default Whichkey mappings
--
lvim.builtin.which_key.mappings['c'] = {}
lvim.builtin.which_key.mappings['w'] = {}

--
-- Whichkey settings for normal mode
--
lvim.builtin.which_key.mappings['<leader>'] = {
  name = "Folding", -- refere which_key for visual mode for making fold
  o = { "zo", "Fold open" },
  c = { "zc", "Fold close" },
  n = { "zn", "All fold open" },
  N = { "z<S-N>", "All fold close" },
  d = { "zd", "Delete fold" },
  D = { "zD", "Delete fold recursively" },
  m = { "<cmd>mkview!<CR>", "Make Vim file for folding (override)" },
  l = { "<cmd>loadview<CR>", "Make Vim file for folding (if exist)" },
}

lvim.builtin.which_key.mappings['b'] = {
  name = "Buffers",
  d = { "<cmd>mkview<CR><cmd>BufferKill<CR>", "Close Buffer (with mkview)" },
  c = { "<cmd>BufferKill<CR>", "Close Buffer (normal)" },
  j = { "<cmd>BufferLinePick<cr>", "Jump" },
  f = { "<cmd>Telescope buffers<cr>", "Find" },
  h = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
  l = { "<cmd>BufferLineCycleNext<cr>", "Next" },
  e = { "<cmd>BufferLinePickClose<cr>", "Pick which buffer to close" },
  D = { "<cmd>BufferLineSortByDirectory<cr>", "Sort by directory" },
  L = { "<cmd>BufferLineSortByExtension<cr>", "Sort by language" },
}

lvim.builtin.which_key.mappings['w'] = {
  name = "Save",
  w = { "<cmd>w!<CR>", "Save (override)" },
  f = { "<cmd>lua require('lvim.lsp.utils').format() <CR><cmd>w!<CR>", "Format save (override)" },
}

-- Note : using neo-tree
lvim.builtin.which_key.mappings['e'] = {}
lvim.builtin.which_key.mappings['e'] = { "<cmd>Neotree<CR>", "Explorer" }

--
-- Whichkey settings for normal mode
--
lvim.builtin.which_key.vmappings['f'] = { "zf", "Fold selected area" }
--}}}

-- {{{ [[LANGUAGE SPECIFIC KEY MAPPINGS]]

--
-- Julia
-- These settings require toggleterm.nvim
--

-- Send the current line to terminal 1 * you should do it and next after init of julia
lvim.keys.normal_mode["<C-j>"] = "<esc><cmd>ToggleTermSendCurrentLine 1<CR>/^.<Bslash>+<CR><cmd>nohlsearch<CR>"
-- Send the selected block to terminal 1
lvim.keys.visual_mode["<C-j>"] = ":'<,'>ToggleTermSendVisualLines 1<CR><S-]>"
-- Exeute the current file in terminal 2
lvim.keys.normal_mode["<C-A-j>"] = "<esc><cmd>2TermExec cmd='cd %:p:h && julia -q %:t' open=0<CR><cmd>2ToggleTerm<CR>"

-- Whichkey mappings in normal mode
lvim.builtin.which_key.mappings["j"] = {
  name = "Julia",
  i = {
    "<cmd>1TermExec cmd='julia -q' open=0<CR><cmd>1ToggleTerm<CR>",
    "Init Julia REPL"
  },
  l = {
    "<esc><cmd>ToggleTermSendCurrentLine 1<CR>",
    "Send a line to julia REPL"
  },
  q = {
    "<cmd>1TermExec cmd='exit()' open=0<CR><cmd>1ToggleTerm<CR>",
    "Exit Julia"
  },
}

-- Whichkey mappings in visual mode
-- lvim.builtin.which_key.vmappings["j"] = {
--   name = "Julia",
-- }
--}}}

--}}}

-- {{{ [TREESITTER]
lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "json",
  "lua",
  "python",
  "rust",
  "julia",
}
-- }}}

-- {{{ [LSP]
lvim.lsp.automatic_servers_installation = false
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "julials", "texlab" })


-- ltex language server
--

-- local wpath = vim.fn.stdpath("config") .. "/spell/en.utf8.add"
-- local mypath = vim.fn.stdpath("config") .. "/spell"
-- local words = {}

-- for word in io.open(wpath, "r"):lines() do
--   table.insert(words, word)
-- end

-- local capabilities = vim.lsp.protocol.make_client_capabilities()

-- require('lspconfig').ltex.setup {
--   capabilities = capabilities,
--   on_attach = function(client, bufnr)
--     -- rest of your on_attach process.
--     local mypath = vim.fn.stdpath("config") .. "/spell"
--     require("ltex_extra").setup {
--       load_langs = { "en-US" }, -- table <string> : languages for witch dictionaries will be loaded
--       init_check = true,        -- boolean : whether to load dictionaries on startup
--       path = mypath,
--       log_level = "none",       -- string : "none", "trace", "debug", "info", "warn", "error", "fatal"
--   }
--   end,
--   settings = {
--     ltex = {
--       checkFrequency = "save",
--       sentenceCacheSize = 5000,
--       disableRules = {
--         ['en-US'] = { 'PROFANITY' }
--       },
--       dictionary = {
--         -- ['en-US'] = { 'Shion', 'Eulerian' }
--         ['en-US'] = words,
--       },
--     },
--   },
-- }

vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "eol:↴"
vim.opt.termguicolors = true
-- vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 ]]
-- vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B ]]
-- vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 ]]
-- vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 ]]
-- vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF ]]
-- vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD ]]

require('lspconfig').ltex.setup {
  -- capabilities = capabilities,
  -- on_attach = function(client, bufnr)
  --   -- rest of your on_attach process.
  --   require("ltex_extra").setup {
  --     load_langs = { "en-US" }, -- table <string> : languages for witch dictionaries will be loaded
  --     init_check = true,        -- boolean : whether to load dictionaries on startup
  --     path = mypath,
  --     -- log_level = "none",       -- string : "none", "trace", "debug", "info", "warn", "error", "fatal"
  -- }
  -- end,
  on_attach = function(client, bufnr)
    -- vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    require("ltex-utils").on_attach(bufnr)
  end,
  settings = {
    ltex = {
      additionalRules = {
        enablePickyRules = true,
        motherTongue = 'en',
        languageModel = '~/ngram',
      },
      checkFrequency = "save",
      disabledRules = {
        ['en-US'] = { 'PROFANITY', 'PASSIVE_VOICE' },
        ['en-GB'] = { 'PROFANITY', 'PASSIVE_VOICE' },
      },
      -- dictionary = {
      --   ['en-US'] = words,
      --   ['en-GB'] = words,
      -- },
      filetypes = { "bib", "gitcommit", "markdown", "org", "plaintex", "rst", "rnoweb", "tex" },
      -- filetypes = { "markdown", "tex", "mdx" }
      -- filetypes = { "tex" },
      -- enabled = { "latex", "tex", "bib" },
      enabled = { "latex", "tex", "bib", "md" },
    },
  },
}
--}}}

-- {{{ [PLUGINS]
--
--Additional Plugins
--
lvim.plugins = {
  {
    "Mofiqul/dracula.nvim"
  },
  {
    "rafi/awesome-vim-colorschemes"
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  { "JuliaEditorSupport/julia-vim" },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        enable_normal_mode_for_inputs = false,                             -- Enable normal mode for input dialogs.
        open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
        sort_case_insensitive = false,                                     -- used when sorting files and directories in the tree
        sort_function = nil,                                               -- use a custom function for sorting files and directories in the tree
        -- sort_function = function (a,b)
        --       if a.type == b.type then
        --           return a.path > b.path
        --       else
        --           return a.type > b.type
        --       end
        --   end , -- this sorts files and directories descendantly
        default_component_configs = {
          container = {
            enable_character_fade = true
          },
          indent = {
            indent_size = 2,
            padding = 1, -- extra padding on left hand side
            -- indent guides
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            -- expander config, needed for nesting files
            with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
          },
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "󰜌",
            -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
            -- then these will never be used.
            default = "*",
            highlight = "NeoTreeFileIcon"
          },
          modified = {
            symbol = "[+]",
            highlight = "NeoTreeModified",
          },
          name = {
            trailing_slash = false,
            use_git_status_colors = false,
            highlight = "NeoTreeFileName",
          },
          git_status = {
            symbols = {
              -- Change type
              added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
              modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
              deleted   = "✖", -- this can only be used in the git_status source
              renamed   = "󰁕", -- this can only be used in the git_status source
              -- Status type
              untracked = "",
              ignored   = "",
              unstaged  = "󰄱",
              staged    = "",
              conflict  = "",
            }
          },
        },
        window = {
          position = "float",
          width = 40,
        },
        buffers = {
          follow_current_file = true,
        },
        filesystem = {
          follow_current_file = true,
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_by_name = {
              "node_modules"
            },
            never_show = {
              ".DS_Store",
              "thumbs.db"
            },
          },
        },
      })
    end
  },
  -- {
  --   "barreiroleo/ltex-extra.nvim",
  --   }
  {
    "jhofscheier/ltex-utils.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
      -- "nvim-telescope/telescope-fzf-native.nvim", -- optional
    },
    opts = {
      dictionary = {
        -- Path to the directory where dictionaries are stored
        -- Defaults to the Neovim cache directory
        path = vim.fn.stdpath("config") .. "/spell/",
        ---Returns the dictionary file name for given language `lang`
        filename = function(lang)
          return "ltex.dictionary." .. lang .. ".txt"
        end,
        -- use vim internal dictionary to add unkown words
        use_vim_dict = false,
        -- show/suppress vim command output such as `spellgood` or `mkspell`
        vim_cmd_output = false,
      },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function()
      require("indent_blankline").setup({
        -- for example, context is off by default, use this to turn it on
        filetype_exclude = { "help", "terminal", "dashboard", "lspinfo" },
        buftype_exclude = { "terminal", "dashboard", "nofile", "quickfix" },
        show_trailing_blankline_indent = false,
        show_first_indent_level = true,
        show_current_context = true,
        show_current_context_start = true,
        -- char_highlight_list = {
        --   "IndentBlanklineIndent1",
        --   "IndentBlanklineIndent2",
        --   "IndentBlanklineIndent3",
        --   "IndentBlanklineIndent4",
        --   "IndentBlanklineIndent5",
        --   "IndentBlanklineIndent6",
        -- },
      })
    end,
  },
  {
    "matze/vim-tex-fold"
  },
  {
    "xiyaowong/telescope-emoji.nvim",
    config = function()
      require("telescope").load_extension("emoji")
    end,
  },
}
-- }}}

--{{{ [Autocommand configuration]
--Detail of autocommand, please refer the webpage https://www.lunarvim.org/docs/configuration/autocommands
vim.api.nvim_create_autocmd("FileType", {
  pattern = "zsh",
  callback = function()
    -- let treesitter use bash highlight for zsh files as well
    require("nvim-treesitter.highlight").attach(0, "bash")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "lua" then
      vim.opt.foldmethod = "marker"
      return
    end
  end,
})
--}}}

vim.cmd [[
  runtime macros/matchit.vim
]]

vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    local root_dir = require("lspconfig").util.root_pattern('.git')
    print("[Debug] root dir = ", root_dir)
  end,
})

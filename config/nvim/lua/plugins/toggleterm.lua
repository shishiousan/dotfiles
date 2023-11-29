local j_tnum = "10"
local j_tnum_int = 10
return {
  {
    "akinsho/toggleterm.nvim",
    -- event =  "VeryLazy",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "ibhagwan/fzf-lua",
      { "echasnovski/mini.indentscope", version = "*" },
    },
    version = "*",
    opts = {
      --[[ things you want to change go here]]
      direction = "vertical", -- "vertical", "horizontal", or "float"
      size = vim.o.columns * 0.4,
      shade_terminals = false,
      open_mapping = [[<c-\>]],
      winbar = {
        enabled = false,
        name_formatter = function(term) --  term: Terminal
          return term.name
        end,
      },
    },
    keys = {
      {
        -- "<leader>JI",
        "<F5>",
        "<cmd>" .. j_tnum .. "TermExec cmd='julia -q --project' open=0<CR><cmd>" .. j_tnum .. "ToggleTerm<CR><C-w>h",
        mode = { "n" },
        silent = false,
        desc = "Init Julia",
      },
      {
        -- "<leader>JE",
        "<F6>",
        "<cmd>" .. j_tnum .. "TermExec cmd='exit()' open=0<CR><cmd>" .. j_tnum .. "ToggleTerm<CR><C-w>h",
        mode = { "n" },
        silent = false,
        desc = "Exit Julia",
      },
      --{
      -- BUG: Does not work well
      -- "<A-CR>",
      -- "<cmd>'<,'>ToggleTermSendVisualSelection " .. j_tnum .. "<CR>",
      -- "<cmd>ToggleTermSendVisualLines "
      -- .. j_tnum
      -- .. "<CR>",
      -- "<cmd>'<,'>s/end/test/g<CR>",
      -- silent = true,
      -- mode = { "v", "x" },
      --},
      -- {
      --   "<leader>ts",
      --   function()
      --     require("toggleterm").exec_command("cmd='" .. vim.fn.getreg('"') .. "'", j_tnum_int)
      --   end,
      --   silent = true,
      --   mode = { "n" },
      --   desc = 'Send @" to toggleterm ' .. j_tnum_int,
      -- },
      {
        "<C-A-n>",
        "<esc><cmd>"
          .. 2 * j_tnum
          .. "TermExec cmd='cd %:p:h && julia -q %:t' open=0<CR><cmd>"
          .. 2 * j_tnum
          .. "ToggleTerm<CR><C-w>h",
        silent = false,
        mode = { "n", "i" },
      },
      {
        "<S-CR>",
        function()
          local mini_ind_scope = require("mini.indentscope")
          local ind_scope_top = mini_ind_scope.get_scope().border.top
          if ind_scope_top == 0 then
            -- require("toggleterm").send_lines_to_terminal("visual_selection", true, { args = j_tnum_int })
            require("toggleterm").send_lines_to_terminal("single_line", false, { args = j_tnum_int })
            vim.cmd("silent! /^.\\+")
            vim.cmd("nohlsearch")
          else
            mini_ind_scope.textobject(true)
          end
        end,
        silent = true,
        mode = { "n" },
      },
      {
        "<S-CR>",
        function()
          vim.cmd("normal !")
          local mini_ind_scope = require("mini.indentscope")
          local ind_scope_top = mini_ind_scope.get_scope().border.top
          if ind_scope_top == 0 then
            -- require("toggleterm").send_lines_to_terminal("visual_selection", true, { args = j_tnum_int })
            require("toggleterm").send_lines_to_terminal("single_line", false, { args = j_tnum_int })
            vim.cmd("silent! /^.\\+")
            vim.cmd("nohlsearch")
          else
            mini_ind_scope.textobject(true)
            local keys = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
            vim.api.nvim_feedkeys(keys, "i", true)
          end
        end,
        silent = true,
        mode = { "i" },
      },
      -- {
      --   "<S-CR>",
      --   function()
      --     local str, _ = require("fzf-lua.utils").get_visual_selection()
      --     require("toggleterm").exec_command("cmd='" .. str .. "'", j_tnum_int)
      --     -- require("toggleterm").send_lines_to_terminal("visual_lines", false, { args = j_tnum_int }) -- does not work
      --     -- vim.cmd(":'<,'>ToggleTermSendVisualLines " .. j_tnum) -- also not work
      --     vim.cmd("silent! /^.\\+")
      --     vim.cmd("nohlsearch")
      --   end,
      --   silent = true,
      --   mode = { "v" },
      -- },
      {
        "<S-CR>",
        ":'<,'>ToggleTermSendVisualLines " .. j_tnum .. "<CR>`>:silent! /^.\\+<CR>:nohlsearch<CR>",
        silent = true,
        mode = { "v" },
      },
      -- TODO: add function skip comment line
      -- tips for this are vim.opt.commentstring._value, (it needs string.sub or matching)
      -- vim.fn.getlinen('.'):sub(1,1)
      -- while there is no matcing skip current line
    },
  },
}

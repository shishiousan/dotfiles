return {
  {
    "github/copilot.vim",
    lazy = false,
    config = function()
      vim.keymap.set("i", "<C-M>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
      })

      -- to cooperate with nvim-cmp
      vim.g.copilot_no_tab_map = true

      -- TODO: translate this into lua ver
      vim.cmd([[ 
      let g:copilot_filetypes = {
          \ '*': v:false, 
          \ 'fortran': v:true, 
          \ 'lua': v:true, 
          \ 'go': v:true, 
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
}

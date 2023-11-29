return {
  {
    "norcalli/nvim-colorizer.lua",
    lazy = true,
    event = "BufRead",
    config = function()
      require("colorizer").setup({})
    end,
    keys = {
      {
        "<leader>uH",
        "<cmd>ColorizerToggle<CR>",
        desc = "Colorizer Toggle",
      },
    },
    -- vim.keymap.set("n", "<leader>ah", "<cmd>ColorizerToggle<CR>", { silent = false }),
  },
  {
    "xiyaowong/transparent.nvim",
    lazy = true,
    config = function()
      require("transparent").setup({
        extra_groups = {
          "NormalFloat", -- plugins which have float panel such as Lazy, Mason, LspInfo
        },
      })
    end,
    keys = {
      {
        "<leader>ut",
        "<cmd>TransparentToggle<CR>",
        desc = "Transparent Toggle",
      },
    },
  },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    lazy = true,
    dependencies = {
      "junegunn/fzf",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({})
    end,
    keys = {
      {
        "<leader>F",
        "<cmd>FzfLua builtin<CR>",
        mode = { "n" },
        silent = true,
        desc = "fzf-lua builtin",
      },
    },
  },
}

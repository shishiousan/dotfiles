return {
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
      {
        "<leader>fF",
        "<cmd>FzfLua files<CR>",
        mode = { "n" },
        silent = true,
        desc = "Files (Root)",
      },
      {
        "<leader><leader>",
        "<cmd>FzfLua files<CR>",
        mode = { "n" },
        silent = true,
        desc = "Files (Root)",
      },
      {
        "<leader>ff",
        "<cmd>FzfLua files cwd=%:h:p<CR>",
        mode = { "n" },
        silent = true,
        desc = "Files (cwd)",
      },
      {
        "<leader>fg",
        "<cmd>FzfLua git_files<CR>",
        mode = { "n" },
        silent = true,
        desc = "Git Files (cwd)",
      },
      {
        "<leader>fr",
        "<cmd>FzfLua oldfiles<CR>",
        mode = { "n" },
        silent = true,
        desc = "Recent files",
      },
      {
        "<leader>fR",
        "<cmd>FzfLua oldfiles cwd=%:h:p<CR>",
        mode = { "n" },
        silent = true,
        desc = "Recent files (cwd)",
      },
      {
        "<leader>fb",
        "<cmd>FzfLua buffers <CR>",
        mode = { "n" },
        silent = true,
        desc = "Buffers",
      },
    },
  },
}

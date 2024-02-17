return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "nushell/tree-sitter-nu" },
    },
    build = ":TSUpdate",
  },
  {
    "LhKipp/nvim-nu",
    filetypes = { "nu" },
  },
  {
    "dag/vim-fish",
    filetypes = { "fish" },
  },
}

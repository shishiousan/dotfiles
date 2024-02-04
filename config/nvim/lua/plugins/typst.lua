return {
  {
    "kaarmu/typst.vim",
    ft = "typst",
    lazy = false,
    config = function()
      vim.g.typst_pdf_viewer = "zathura"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- servers = {
      --   typst_lsp = {
      --     settings = {
      --       typst = {
      --         exportPdf = "never",
      --       },
      --     },
      --   },
      -- },
      setup = {
        typst_lsp = function()
          print("typst_lsp")
          require("lspconfig").typst_lsp.setup({
            settings = {
              exportPdf = "onType",
            },
          })
        end,
      },
    },
  },
}

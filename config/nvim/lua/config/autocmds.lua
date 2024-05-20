-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("expr_folding"),
  pattern = { "fortran", "lua" },
  callback = function()
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.opt_local.foldtext = "v:lua.vim.treesitter.foldtext()"
    vim.opt_local.foldnestmax = 2
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("marker_folding"),
  pattern = { "bash" },
  callback = function()
    vim.opt_local.foldmethod = "marker"
    vim.opt_local.foldcolumn = "2"
    vim.opt_local.foldnestmax = 1
    vim.cmd("set foldopen-=block")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("no_folding"),
  pattern = { "TelescopeResults", "ToggleTerm", "Noice", "sagaoutline", "dashboard" },
  callback = function()
    vim.opt_local.foldenable = false
    vim.opt_local.foldcolumn = "0"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("vert help"),
  pattern = { "help" },
  callback = function()
    vim.cmd("wincmd L")
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("markdown_keys_set", { clear = true }),
  pattern = { "markdown" },
  callback = function()
    local wk = require("which-key")
    wk.register({
      m = {
        name = "+markdown",
        p = { "<cmd>MarkdownPreview<CR>", "markdown preview" },
        -- p = { "<cmd>PeekOpen<CR>", "markdown preview" },
        s = { "<cmd>MarkdownPreviewStop<CR>", "stop markdown preview" },
        -- s = { "<cmd>PeekClose<CR>", "stop markdown preview" },
      },
    }, { prefix = "<leader>", mode = { "n" } })
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("typst", { clear = true }),
  pattern = { "typst" },
  callback = function()
    local wk = require("which-key")
    wk.register({
      T = {
        name = "+Typst",
        w = { "<cmd>TypstWatch<CR>", "watch typst docment" },
      },
    }, { prefix = "<leader>", mode = { "n" } })
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = augroup("hide_decorations"),
  pattern = { "*" },
  callback = function()
    local lualine = require("lualine")
    local stat = vim.g.statStatusLine
    if stat == nil or stat then
      lualine.hide({ unhide = false })
      vim.g.statStatusLine = false
      vim.cmd([[set laststatus=0]])
      vim.cmd([[hi! link StatusLine Normal]])
      vim.cmd([[hi! link StatusLineNC Normal]])
      vim.cmd([[set statusline=%{repeat('─',winwidth('.'))}]])
    end
    vim.cmd("set showtabline=0")
  end,
})

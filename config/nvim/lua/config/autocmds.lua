-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("indent_folding"),
  pattern = { "julia", "lua" },
  -- pattern = { "lua" },
  callback = function()
    vim.opt_local.foldmethod = "indent"
    vim.opt_local.foldcolumn = "2"
    vim.opt_local.foldnestmax = 1
    vim.cmd("set foldopen-=block")
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
  group = augroup("expr_folding"),
  pattern = { "tex" },
  callback = function()
    -- vim.g.vimtex_fold_enabled = 1
    vim.opt_local.foldcolumn = "2"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("no_folding"),
  pattern = { "TelescopeResults", "ToggleTerm", "Noice", "sagaoutline" },
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

-- vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
--   group = augroup("additional_syntax"),
--   pattern = { "fortran" },
--   callback = function()
--     vim.cmd("syn keyword myfortrankey ASYNCHRONOUS")
--     vim.cmd("hi link myfortrankey Type")
--   end,
-- })

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("markdown_keys_set", { clear = true }),
  pattern = { "markdown" },
  callback = function()
    local wk = require("which-key")
    wk.register({
      m = {
        name = "+markdown",
        -- p = { "<cmd>MarkdownPreview<CR>", "markdown preview" },
        p = { "<cmd>PeekOpen<CR>", "markdown preview" },
        -- s = { "<cmd>MarkdownPreviewStop<CR>", "stop markdown preview" },
        s = { "<cmd>PeekClose<CR>", "stop markdown preview" },
      },
    }, { prefix = "<leader>", mode = { "n" } })
  end,
})

-- NOTE: if statement is necessary to prevent
-- wrong cut (x) in neo-tree filesystem
vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup("debug_for_folding"),
  pattern = { "*" },
  callback = function()
    local filetype = vim.bo.filetype
    if filetype == "tex" then
      vim.cmd("normal zx") -- update the folding
    end
  end,
})

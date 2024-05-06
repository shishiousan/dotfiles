-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- make comment normal font
-- vim.cmd("hi Comment gui=NONE")
-- vim.api.nvim_set_hl(0, "Comment", { italic = false })
vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "eol:↴"
-- NOTE: on the default prohibit to go back to top
-- from last line in search.
vim.opt.wrapscan = false
-- vim.opt.foldnestmax = 2
-- vim.opt.foldlevelstart = 1
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"
-- vim.opt.foldnestmax = 1

vim.api.nvim_create_user_command("CheckScreen", function()
  local width = vim.fn.winwidth(0)
  local height = vim.fn.winheight(0)
  local nrow = vim.api.nvim_eval("&lines")
  local ncol = vim.api.nvim_eval("&columns")

  print("wedth, height, nrow, ncol")
  print(width, height, nrow, ncol)

  local split = not (width == ncol)
  local vsplit = not (height == nrow)

  if split and vsplit then
    print("current buffer is in both horizontal and vertical split")
    return
  elseif split then
    print("current buffer is in horizontal split")
    return
  elseif vsplit then
    print("current buffer is in vertical split")
    return
  end
end, {})

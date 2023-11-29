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

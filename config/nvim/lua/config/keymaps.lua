-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- exit by jj
map("i", "jk", "<esc>")
-- map("i", "jj", "<esc>")

-- remove hilight
map("n", "<C-n>", "<cmd>nohlsearch<CR>")

-- yank and paste
--normal
map("n", "<leader>j", "yyp", { desc = "Paste line below" })
map("n", "<leader>k", "yyP", { desc = "Paste line above" })
--visual
map("v", "<leader>j", "Yp", { desc = "Paste below" })
map("v", "<leader>k", "YP", { desc = "Paste above" })

-- alternative for zoom out and in
map("n", "<leader>zi", "<cmd>tab split<CR>", { desc = "Zoom in" })
map("n", "<leader>zo", "<cmd>tab close<CR>", { desc = "Zoom out" })

-- floating terminal
local lazyterm = function()
  Util.terminal.open(nil, { cwd = Util.root.get() })
end
map("n", "<leader>ft", lazyterm, { desc = "Terminal (root dir)" })
map("n", "<leader>fT", function()
  Util.terminal.open(nil, { cwd = vim.fn.expand("%:p:h"), border = "rounded" })
end, { desc = "Terminal (cwd)" })
-- map("n", "<c-/>", lazyterm, { desc = "Terminal (root dir)" })
map("n", "<c-/>", function()
  Util.terminal.open(nil, { cwd = vim.fn.expand("%:p:h"), border = "rounded" })
end, { desc = "Terminal (cwd)" })
map("n", "<c-_>", function()
  Util.terminal.open(nil, { cwd = vim.fn.expand("%:p:h"), border = "rounded" })
end, { desc = "Terminal (cwd)" })
-- map("n", "<c-_>", lazyterm, { desc = "which_key_ignore" })
-- vim.keymap.del("n", "<c-_>") -- used by wezterm "decrease font size"

-- save file
map("n", "<leader>fs", "<cmd>silent! w<CR>", { desc = "write" })
map("n", "<leader>fa", "<cmd>silent! wa<CR>", { desc = "write all" })
map("n", "<leader>fq", "<cmd>silent! wa<CR><cmd>qa<CR>", { desc = "write all and quit all" })

map("n", "<leader>rp", "o<esc>v:'<,'>!erun -bs %<CR>")
-- map("n", "<leader>rr", ":!erun -bs %<CR>")
map("n", "<leader>rr", function()
  local text = vim.cmd([[!erun -bs %]])
  vim.print(text)
end)
-- map("n", "<leader>rcp", "o<esc>v:'<,'>!erun -cs %<CR>")
-- map("n", "<leader>rcc", ":!erun -cs %<CR>")
-- map("n", "<leader>rep", "o<esc>v:'<,'>!erun -es %<CR>")
-- map("n", "<leader>ree", ":!erun -es %<CR>")
-- map("n", "<leader>rap", "o<esc>v:'<,'>!erun -as %<CR>")
-- map("n", "<leader>raa", ":!erun -as %<CR>")

-- NOTE:
-- Following settings for <C-j> is to be active
-- when <S-CR> keymap, defined in ToggleTerm plugin file, does not work
--
-- vim.keymap.del("t", "<C-j>")
-- vim.keymap.del({ "n", "t" }, "<C-j>")
-- vim.keymap.del({ "n", "t" }, "<C-k>")
-- vim.keymap.del({ "n", "t" }, "<C-l>")
-- vim.keymap.del({ "n", "t" }, "<C-h>")
-- vim.keymap.set(
--   "n",
--   "<C-j>",
--   "<esc><cmd>ToggleTermSendCurrentLine " .. "10" .. "<CR>/^.<Bslash>+<CR><cmd>nohlsearch<CR>",
--   { silent = true }
-- )

-- map({ "x", "o" }, "ai", "ai", { remap = true })
-- map({ "n" }, "<leader>Jt", "Vip", { desc = "test", remap = true })

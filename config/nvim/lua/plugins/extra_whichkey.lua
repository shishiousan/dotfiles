local wk = require("which-key")

wk.register({
  z = {
    name = "Zoom",
    i = { "<cmd>tab split<CR>", "Zoom in" },
    o = { "<cmd>tab close<CR>", "Zoom out" },
  },
  w = {
    name = "window",
    h = { "<Ctrl>h", "Move to left" },
    j = { "<Ctrl>j", "Move down" },
    k = { "<Ctrl>k", "Move up" },
    l = { "<Ctrl>l", "Move to right" },
  },
}, { prefix = "<leader>", mode = "n" })

return {
  "folke/which-key.nvim",
  opts = {
    window = {
      border = "double", -- none, single, double, shadow
      position = "bottom", -- bottom, top
      margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
      padding = { 0, 0, 0, 0 }, -- extra window padding [top, right, bottom, left]
      winblend = 0, -- value between 0-100 0 for fully opaque and 100 for fully transparent
      zindex = 1000, -- positive value to position WhichKey above other floating windows.
    },
  },
}

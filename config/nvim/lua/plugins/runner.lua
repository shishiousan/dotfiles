return {
  {
    "stevearc/overseer.nvim",
    lazy = false,
    opts = {},
    keys = {
      {
        "<leader>or",
        "<cmd>OverseerRun<CR>",
        mode = { "n" },
        desc = "Overseer Run",
      },
      {
        "<leader>ot",
        "<cmd>OverseerToggle<CR>",
        mode = { "n" },
        desc = "Overseer Toggle",
      },
      {
        "<leader>oi",
        "<cmd>OverseerInfo<CR>",
        mode = { "n" },
        desc = "Overseer Info",
      },
    },
  },
}

return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      cmdline = {
        enabled = true, -- enables the Noice cmdline UI
        view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
        opts = {
          position = {
            row = "35%",
            col = "50%",
          },
          size = {
            width = 90,
            height = 1,
          },
          border = {
            style = "rounded",
            text = {
              top = " COMMAND LINE ",
              top_align = "center",
            },
          },
        }, -- global options for the cmdline. See section on views
      },
      presets = {
        bottom_search = true,
        command_palette = false,
        long_message_to_split = true,
        inc_rename = true,
      },
    },
  },
}

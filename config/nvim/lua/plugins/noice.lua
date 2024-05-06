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
            row = "10%",
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
      routes = {
        {
          view = "split",
          filter = {
            event = "msg_show",
            min_height = 2,
          },
          opts = { lang = "fortran" },
        },
      },
      presets = {
        bottom_search = true,
        command_palette = false,
        long_message_to_split = true,
        inc_rename = true,
      },
      message = {
        -- Messages shown by lsp servers
        enabled = true,
        view = "notify",
        opts = {},
      },
      views = {
        vsplit = {
          enter = true,
        },
        split = {
          enter = true,
        },
      },
    },
  },
}

return {
  {
    "mistricky/codesnap.nvim",
    build = "make",
    config = function()
      require("codesnap").setup({
        mac_window_bar = false,
        title = "PengVim",
        code_font_family = "CaskaydiaCove Nerd Font",
        watermark_font_family = "Pacifico",
        watermark = "PengVim",
        bg_theme = "grape",
        breadcrumbs_separator = "/",
        has_breadcrumbs = true,
        save_path = "/home/shion/Documents",
      })
    end,
  },
}

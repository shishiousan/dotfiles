return {
  -- add telescope-fzf-native
  {
    "telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "nvim-telescope/telescope-bibtex.nvim",
    },
    opts = {
      defaults = {
        layout_strategy = "center",
        -- horizontal, center, vertical, flex
        layout_config = {
          center = {
            -- The `anchor` can be any of the following strings:
            --   - "", "CENTER", "NW", "N", "NE", "E", "SE", "S", "SW", "W" The anchors
            --     have the following meanings:
            --   - "" or "CENTER":
            --     the picker will remain in the middle of the screen.
            --   - Compass directions:
            --     the picker will move to the corresponding edge/corner e.g. "NW" -> "top
            --     left corner", "E" -> "right edge", "S" -> "bottom edge"
            anchor = "N",
            height = 0.35,
            width = 0.8,
            prompt_position = "bottom",
            preview_cutoff = 1,
          },
          horizontal = {
            prompt_position = "top",
            preview_cutoff = 1,
          },
        },
      },
      load_extension = { "bibtex" },
      extensions = {
        bibtex = {
          depth = 1,
          -- Depth for the *.bib file
          custom_formats = {},
          -- Custom format for citation label
          format = "",
          -- Format to use for citation label.
          -- Try to match the filetype by default, or use 'plain'
          -- global_files = { "~/texmf/bibtex/bib/test.bib" },
          global_files = { "~/texmf/bibtex/bib/Zotero.bib" },
          -- Path to global bibliographies (placed outside of the project)
          search_keys = { "author", "year", "title" },
          -- Define the search keys to use in the picker
          citation_format = "{{author}} ({{year}}), {{title}}.",
          -- Template for the formatted citation
          citation_trim_firstname = true,
          -- Only use initials for the authors first name
          citation_max_auth = 2,
          -- Max number of authors to write in the formatted citation
          -- following authors will be replaced by "et al."
          context = false,
          -- Context awareness disabled by default
          context_fallback = true,
          -- Fallback to global/directory .bib files if context not found
          -- This setting has no effect if context = false
          wrap = false,
          -- Wrapping in the preview window is disabled by default
        },
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("bibtex")
      require("telescope").load_extension("fzf")
    end,
  },
}

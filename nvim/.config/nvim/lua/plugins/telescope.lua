return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-media-files.nvim",
  },
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<C-j>"] = require("telescope.actions").cycle_history_next,
          ["<C-k>"] = require("telescope.actions").cycle_history_prev,
          ["<C-n>"] = require("telescope.actions").move_selection_next,
          ["<C-p>"] = require("telescope.actions").move_selection_previous,
        },
      },
    },
    pickers = {
      find_files = {
        theme = "dropdown",
      },
    },
  },
  -- config = function(plugin, opts)
  --   require "plugins.configs.telescope"(plugin, opts)
  --   local telescope = require "telescope"
  --   telescope.load_extension "media_files"
  -- end,
}

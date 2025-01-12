---@type LazySpec
return {
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        "  __      _____ ____",
        " /---__  ( (O)|/(O) )",
        "  \\\\\\\\/  \\___/U\\___/",
        "    L\\       ||",
        "     \\\\ ____|||_____",
        "      \\\\|==|[]__/==|\\-|",
        "       \\|* |||||\\==|/-|",
        "    ____| *|[][]-- |_",
        "   ||EEE|__EEEE_[]_|EE\\",
        "   ||EEE|=O     O|=|EEE|",
        "   \\LEEE|         \\|EEE|  __))",
        "                          ```",
      }
      return opts
    end,
  },
  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require("lsp_signature").setup()
    end,
  },
  { "max397574/better-escape.nvim", enabled = false },
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require("astronvim.plugins.configs.luasnip")(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require("luasnip")
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    config = function()
      local kanagawa = require("kanagawa")
      kanagawa.setup({
        transparent = true,
        theme = "wave",
      })
    end,
  },
  { "m-pilia/vim-pkgbuild",         lazy = false },
  { "iamcco/markdown-preview.nvim", lazy = false },
  {
    "akinsho/git-conflict.nvim",
    tag = "v2.1.0",
    config = function()
      require("git-conflict").setup({
        default_mappings = false,
      })
    end,
    lazy = false,
  },
  { "folke/zen-mode.nvim",             lazy = false },
  { "mbbill/undotree",                 lazy = false },
  { "tpope/vim-fugitive",              lazy = false },
  { "Eandrju/cellular-automaton.nvim", lazy = false },
  { "segeljakt/vim-silicon",           lazy = false },
  { "TheBlob42/houdini.nvim",          lazy = false },
  { "mzlogin/vim-markdown-toc",        lazy = false },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require("lsp_signature").setup()
    end,
  },
  {
    "ruifm/gitlinker.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      local gitlinker = require("gitlinker")
      gitlinker.setup()
    end,
    lazy = false,
  },
  {
    "henriklovhaug/Preview.nvim",
    cmd = { "Preview" },
    config = function()
      require("preview").setup()
    end,
  },
  { "github/copilot.vim" },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "zjp-CN/nvim-cmp-lsp-rs",
        ---@type cmp_lsp_rs.Opts
        opts = {
          -- Filter out import items starting with one of these prefixes.
          -- A prefix can be crate name, module name or anything an import
          -- path starts with, no matter it's complete or incomplete.
          -- Only literals are recognized: no regex matching.
          unwanted_prefix = { "ratatui::crossterm::style::Stylize", "crossterm", "Styled" },
        },
      },
    },
  },
  {
    "sphamba/smear-cursor.nvim",
    opts = {
      stiffness = 0.8,
      trailing_stiffness = 0.5,
      distance_stop_animating = 0.5,
      hide_target_hack = false,
      smear_between_buffers = true,
      smear_between_neighbor_lines = true,
      legacy_computing_symbols_support = false,
    },
  },
}

return {
  {
    "rebelot/kanagawa.nvim",
    config = function()
      local kanagawa = require "kanagawa"
      kanagawa.setup {
        transparent = true,
        theme = "wave",
      }
    end,
  },
  { "m-pilia/vim-pkgbuild", lazy = false },
  { "iamcco/markdown-preview.nvim", lazy = false },
  {
    "akinsho/git-conflict.nvim",
    config = function()
      require("git-conflict").setup {
        default_mappings = false,
      }
    end,
    lazy = false,
  },
  { "folke/zen-mode.nvim", lazy = false },
  { "mbbill/undotree", lazy = false },
  { "tpope/vim-fugitive", lazy = false },
  { "Eandrju/cellular-automaton.nvim", lazy = false },
  { "segeljakt/vim-silicon", lazy = false },
  { "TheBlob42/houdini.nvim", lazy = false },
  { "mzlogin/vim-markdown-toc", lazy = false },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },
  {
    "ruifm/gitlinker.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      local gitlinker = require "gitlinker"
      gitlinker.setup()
    end,
    lazy = false,
  },
  {
    "henriklovhaug/Preview.nvim",
    cmd = { "Preview" },
    config = function() require("preview").setup() end,
  },
}

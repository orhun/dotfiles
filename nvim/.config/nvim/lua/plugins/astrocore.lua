-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`

---@type LazySpec
return {
  "AstroNvim/astrocore",
  lazy = false,
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        -- set to true or false etc.
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "auto", -- sets vim.opt.signcolumn to auto
        wrap = false, -- sets vim.opt.wrap
        smartcase = true, -- sets vim.opt.smartcase
        ignorecase = true, -- sets vim.opt.ignorecase
        modifiable = true,
        autoread = true,
      },
      g = {
        autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
        cmp_enabled = true, -- enable completion at start
        autopairs_enabled = true, -- enable autopairs at start
        diagnostics_enabled = true, -- enable diagnostics at start
        diagnostics_mode = 3, -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
        status_diagnostics_enabled = true, -- enable diagnostics in statusline
        inlay_hints_enabled = true, -- enable or disable LSP inlay hints on startup (Neovim v0.10 only)
        lsp_handlers_enabled = true, -- enable or disable default vim.lsp.handlers (hover and signature help)
        icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
        ui_notifications_enabled = true, -- disable notifications when toggling UI elements
        mkdp_browser = "firefox", -- use Firefox for markdown preview
        silicon = {
          background = "#191a21",
          ["window-controls"] = false,
          -- background = "#161616",
          -- ["theme"] = "gruvbox-dark",
          -- ["pad-horiz"] = 10,
          -- ["pad-vert"] = 10,
          -- ["round-corner"] = true,
        }, -- configure Silicon
        -- silicon = {
        --   background = "#d5cac2",
        --   ["window-controls"] = false,
        --   ["round-corner"] = true,
        --   ["theme"] = "gruvbox-dark",
        --   ["pad-horiz"] = 10,
        --   ["pad-vert"] = 10,
        -- }, -- configure Silicon
        -- noswapfile = true, -- disable swap files
      },
    },
    mappings = {
      n = {
        ["<Leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
        L = {
          function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
          desc = "Next buffer",
        },
        H = {
          function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
          desc = "Previous buffer",
        },
        ["<C-g>"] = { ":ToggleTerm size=30 direction=horizontal<cr>", desc = "Toggle terminal" },
        ["<C-;>"] = { ":ToggleTerm size=30 direction=horizontal<cr>", desc = "Toggle terminal" },
        ["<Leader>;"] = { ":2ToggleTerm size=30 direction=horizontal<cr>", desc = "Open terminal with tab" },
        ["<Leader>r"] = { ":AstroReload<cr>", desc = "Reload AstroNvim" },
        ["<esc>"] = { ":nohl<cr>", desc = "No highlight" },
        ["<C-s>"] = { ":w!<cr>", desc = "Save file" },
        ["<C-q>"] = { ":qa!<cr>", desc = "Exit" },
        ["<C-f>"] = { function() require("telescope.builtin").find_files() end, desc = "Find files" },
        ["<C-k>"] = { function() require("telescope.builtin").live_grep() end, desc = "Find words" },
        ["<C-d>"] = { "<C-d>zz", desc = "Scroll down" },
        ["<C-u>"] = { "<C-u>zz", desc = "Scroll up" },
        ["<A-z>"] = { ":set wrap!<cr>", desc = "Toggle word wrap" },
        ["[x"] = { ":GitConflictPrevConflict<cr>", desc = "Previous Git conflict" },
        ["]x"] = { ":GitConflictNextConflict<cr>", desc = "Next Git conflict" },
        ["cx"] = { ":GitConflictListQf<cr>", desc = "List Git conflicts" },
        ["co"] = { ":GitConflictChooseOurs<cr>", desc = "Git conflict - choose ours" },
        ["ct"] = { ":GitConflictChooseTheirs<cr>", desc = "Git conflict - choose theirs" },
        ["cb"] = { ":GitConflictChooseBoth<cr>", desc = "Git conflict - choose both" },
        ["c0"] = { ":GitConflictChooseNone<cr>", desc = "Git conflict - choose none" },
        ["<Leader>U"] = { ":UndotreeToggle<cr>", desc = "Toggle undo history" },
        ["<Leader>gg"] = { ":Git<cr>", desc = "Open Git" },
        ["<Leader>m"] = { ":MarkdownPreview<cr>", desc = "Show markdown preview" },
        ["<Leader>z"] = { ":ZenMode<cr>", desc = "Toggle Zen mode" },
        ["<Leader>uR"] = { ":CellularAutomaton make_it_rain<cr>", desc = "Make it rain" },
        ["<Leader>uG"] = { ":CellularAutomaton game_of_life<cr>", desc = "Game of life" },
        ["<Leader>uz"] = { ":CellularAutomaton scramble<cr>", desc = "Scramble" },
        ["<Leader>fs"] = { ":Silicon<cr>", desc = "Save image" },
        ["<Leader>fM"] = { ":Telescope media_files<cr>", desc = "Find media files" },
        ["<Leader>s"] = { function() require("resession").load "Last Session" end, desc = "Load last session" },
      },
      i = {
        ["<C-s>"] = { "<esc>:w!<cr>", desc = "Save file" },
        ["<C-q>"] = { "<esc>:qa!<cr>", desc = "Exit" },
      },
      v = {
        ["<Leader>p"] = { '"0p', desc = "Paste without replacing the buffer" },
        ["<C-r>"] = { '"hy:%s/<C-r>h//gc<left><left><left>', desc = "Replace" },
        ["<Leader>s"] = { ":'<,'>Silicon<cr>", desc = "Save image" },
      },
      t = {
        ["<C-g>"] = { "<C-\\><C-N>", desc = "Switch to normal mode" },
        ["<C-;>"] = { "<C-\\><C-N>", desc = "Switch to normal mode" },
      },
    },
  },
}

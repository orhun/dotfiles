--              AstroNvim Configuration Table
-- All configuration changes should go inside of the table below

-- You can think of a Lua "table" as a dictionary like data structure the
-- normal format is "key = value". These also handle array like data structures
-- where a value with no key simply has an implicit numeric key
local config = {

  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "nightly", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "main", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_reload = true, -- automatically reload and sync packer after a successful update
    auto_quit = false, -- automatically quit the current session after a successful update
    -- remotes = { -- easily add new remotes to track
    --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
    --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
    --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    -- },
  },

  -- Set colorscheme to use
  colorscheme = "dracula",

  -- Add highlight groups in any theme
  highlights = {
    -- init = { -- this table overrides highlights in all themes
    --   Normal = { bg = "#000000" },
    -- }
    -- duskfox = { -- a table of overrides/changes to the duskfox theme
    --   Normal = { bg = "#000000" },
    -- },
  },

  -- set vim options here (vim.<first_key>.<second_key> = value)
  options = {
    opt = {
      -- set to true or false etc.
      relativenumber = true, -- sets vim.opt.relativenumber
      number = true, -- sets vim.opt.number
      spell = false, -- sets vim.opt.spell
      signcolumn = "auto", -- sets vim.opt.signcolumn to auto
      wrap = false, -- sets vim.opt.wrap
      smartcase = true, -- sets vim.opt.smartcase
      ignorecase = true, -- sets vim.opt.ignorecase
      modifiable = true,
    },
    g = {
      mapleader = " ", -- sets vim.g.mapleader
      autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
      cmp_enabled = true, -- enable completion at start
      autopairs_enabled = true, -- enable autopairs at start
      diagnostics_enabled = true, -- enable diagnostics at start
      status_diagnostics_enabled = true, -- enable diagnostics in statusline
      icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
      ui_notifications_enabled = true, -- disable notifications when toggling UI elements
      mkdp_browser = "firefox-developer-edition", -- use Firefox for markdown preview
    },
  },
  -- If you need more control, you can use the function()...end notation
  -- options = function(local_vim)
  --   local_vim.opt.relativenumber = true
  --   local_vim.g.mapleader = " "
  --   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
  --   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
  --
  --   return local_vim
  -- end,

  -- Set dashboard header
  header = {
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
  },

  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  -- Extend LSP configuration
  lsp = {
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- "sumneko_lua",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- easily add or disable built in mappings added during LSP attaching
    mappings = {
      n = {
        -- ["<leader>lf"] = false -- disable formatting keymap
      },
    },
    -- add to the global LSP on_attach function
    -- on_attach = function(client, bufnr)
    -- end,

    -- override the mason server-registration function
    -- server_registration = function(server, opts)
    --   require("lspconfig")[server].setup(opts)
    -- end,

    -- Add overrides for LSP server settings, the keys are the name of the server
    ["server-settings"] = {
      -- example for addings schemas to yamlls
      -- yamlls = { -- override table for require("lspconfig").yamlls.setup({...})
      --   settings = {
      --     yaml = {
      --       schemas = {
      --         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
      --         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
      --         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
      --       },
      --     },
      --   },
      -- },
    },
  },

  -- Mapping data with "desc" stored directly by vim.keymap.set().
  --
  -- Please use this mappings table to set keyboard mapping since this is the
  -- lower level configuration and more robust one. (which-key will
  -- automatically pick-up stored data by this setting.)
  mappings = {
    n = {
      ["<esc>"] = { ":nohl<cr>", desc = "No highlight" },
      ["<leader>r"] = { ":AstroReload<cr>", desc = "Reload" },
      ["<C-s>"] = { ":w!<cr>", desc = "Save file" },
      ["<C-q>"] = { ":qa!<cr>", desc = "Exit" },
      ["<A-z>"] = { ":set wrap!<cr>", desc = "Toggle word wrap" },
      ["<C-j>"] = { ":ToggleTerm size=30 direction=horizontal<cr>", desc = "Toggle terminal" },
      ["<leader>;"] = { ":2ToggleTerm size=30 direction=horizontal<cr>", desc = "Open terminal with tab" },
      ["<C-f>"] = { "*", desc = "Search for word" },
      ["[x"] = { ":GitConflictPrevConflict<cr>", desc = "Previous Git conflict" },
      ["]x"] = { ":GitConflictNextConflict<cr>", desc = "Next Git conflict" },
      ["cx"] = { ":GitConflictListQf<cr>", desc = "List Git conflicts" },
      ["co"] = { ":GitConflictChooseOurs<cr>", desc = "Git conflict - choose ours" },
      ["ct"] = { ":GitConflictChooseTheirs<cr>", desc = "Git conflict - choose theirs" },
      ["cb"] = { ":GitConflictChooseBoth<cr>", desc = "Git conflict - choose both" },
      ["c0"] = { ":GitConflictChooseNone<cr>", desc = "Git conflict - choose none" },
      ["<C-d>"] = { "<C-d>zz", desc = "Scroll down" },
      ["<C-u>"] = { "<C-u>zz", desc = "Scroll up" },
      ["<leader>U"] = { ":UndotreeToggle<cr>", desc = "Toggle undo history" },
    },
    i = {
      ["<C-s>"] = { "<esc>:w!<cr>", desc = "Save file" },
      ["<C-q>"] = { "<esc>:qa!<cr>", desc = "Exit" },
    },
    v = {
      ["<C-r>"] = { '"hy:%s/<C-r>h//gc<left><left><left>', desc = "Replace" },
    },
    t = {
      -- ["<esc>"] = { "<C-\\><C-n>", desc = "Back to normal mode" },
    },
  },

  -- Configure plugins
  plugins = {
    init = {
      {
        "Mofiqul/dracula.nvim",
        config = function()
          local dracula = require("dracula")
          dracula.setup({
            transparent_bg = true,
          })
        end,
      },
      { "m-pilia/vim-pkgbuild" },
      { "iamcco/markdown-preview.nvim" },
      {
        "akinsho/git-conflict.nvim",
        tag = "*",
        config = function()
          require("git-conflict").setup({
            default_mappings = false,
          })
        end,
      },
      { "mhinz/vim-crates" },
      { "folke/zen-mode.nvim" },
      { "mbbill/undotree" },
      -- You can disable default plugins as follows:
      -- ["goolord/alpha-nvim"] = { disable = true },

      -- You can also add new plugins here as well:
      -- Add plugins, the packer syntax without the "use"
      -- { "andweeb/presence.nvim" },
      -- {
      --   "ray-x/lsp_signature.nvim",
      --   event = "BufRead",
      --   config = function()
      --     require("lsp_signature").setup()
      --   end,
      -- },

      -- We also support a key value style plugin definition similar to NvChad:
      -- ["ray-x/lsp_signature.nvim"] = {
      --   event = "BufRead",
      --   config = function()
      --     require("lsp_signature").setup()
      --   end,
      -- },
    },
    -- All other entries override the require("<key>").setup({...}) call for default plugins
    ["null-ls"] = function(config) -- overrides `require("null-ls").setup(config)`
      -- config variable is the default configuration table for the setup function call
      -- local null_ls = require "null-ls"

      -- Check supported formatters and linters
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      config.sources = {
        -- Set a formatter
        -- null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.formatting.prettier,
      }
      return config -- return final config table
    end,
    treesitter = { -- overrides `require("treesitter").setup(...)`
      -- ensure_installed = { "lua" },
    },
    ["neo-tree"] = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
          hide_by_pattern = {
            "**/.git",
            "**/.DS_Store",
            "**/node_modules",
            "**/target",
          },
        },
        window = {
          mappings = {
            ["h"] = function(state)
              local node = state.tree:get_node()
              if node.type == "directory" and node:is_expanded() then
                require("neo-tree.sources.filesystem").toggle_directory(state, node)
              else
                require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
              end
            end,
            ["l"] = function(state)
              local node = state.tree:get_node()
              if node.type == "directory" then
                if not node:is_expanded() then
                  require("neo-tree.sources.filesystem").toggle_directory(state, node)
                elseif node:has_children() then
                  require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
                end
              end
            end,
          },
        },
      },
    },
    telescope = {
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
    },
    notify = {
      background_colour = "#000000",
      fps = 30,
      level = 2,
      minimum_width = 50,
      render = "simple",
      stages = "fade",
      timeout = 3000,
      top_down = true,
    },
    -- use mason-lspconfig to configure LSP installations
    ["mason-lspconfig"] = { -- overrides `require("mason-lspconfig").setup(...)`
      -- ensure_installed = { "sumneko_lua" },
    },
    -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
    ["mason-null-ls"] = { -- overrides `require("mason-null-ls").setup(...)`
      -- ensure_installed = { "prettier", "stylua" },
    },
  },

  -- LuaSnip Options
  luasnip = {
    -- Extend filetypes
    filetype_extend = {
      -- javascript = { "javascriptreact" },
    },
    -- Configure luasnip loaders (vscode, lua, and/or snipmate)
    vscode = {
      -- Add paths for including more VS Code style snippets in luasnip
      paths = {},
    },
  },

  -- CMP Source Priorities
  -- modify here the priorities of default cmp sources
  -- higher value == higher priority
  -- The value can also be set to a boolean for disabling default sources:
  -- false == disabled
  -- true == 1000
  cmp = {
    source_priority = {
      nvim_lsp = 1000,
      luasnip = 750,
      buffer = 500,
      path = 250,
    },
  },

  -- Modify which-key registration (Use this with mappings table in the above.)
  ["which-key"] = {
    -- Add bindings which show up as group name
    register = {
      -- first key is the mode, n == normal mode
      n = {
        -- second key is the prefix, <leader> prefixes
        ["<leader>"] = {
          -- third key is the key to bring up next level and its displayed
          -- group name in which-key top level menu
          ["b"] = { name = "Buffer" },
        },
      },
    },
  },

  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    vim.api.nvim_create_autocmd("BufRead", {
      desc = "Indicate out-of-date Cargo dependencies",
      pattern = "Cargo.toml",
      command = "call crates#toggle()",
    })
    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
  end,
}

return config

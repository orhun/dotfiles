-- set vim options here (vim.<first_key>.<second_key> = value)
return {
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
    autoread = true,
  },
  g = {
    mapleader = " ", -- sets vim.g.mapleader
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
      ["pad-horiz"] = 15,
      ["pad-vert"] = 15,
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
}
-- If you need more control, you can use the function()...end notation
-- return function(local_vim)
--   local_vim.opt.relativenumber = true
--   local_vim.g.mapleader = " "
--   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
--   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
--
--   return local_vim
-- end

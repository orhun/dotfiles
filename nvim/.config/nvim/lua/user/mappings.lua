-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  n = {
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    L = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    H = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    },
    ["<leader>b"] = { name = "Buffers" },
    ["<esc>"] = { ":nohl<cr>", desc = "No highlight" },
    ["<C-s>"] = { ":w!<cr>", desc = "Save file" },
    ["<C-q>"] = { ":qa!<cr>", desc = "Exit" },
    ["<C-f>"] = { function() require("telescope.builtin").find_files() end, desc = "Find files" },
    ["<C-k>"] = { function() require("telescope.builtin").live_grep() end, desc = "Find words" },
    ["<C-m>"] = { ":Mason<cr>", desc = "Open Mason installer" },
    ["<C-d>"] = { "<C-d>zz", desc = "Scroll down" },
    ["<C-u>"] = { "<C-u>zz", desc = "Scroll up" },
    ["<A-z>"] = { ":set wrap!<cr>", desc = "Toggle word wrap" },
    ["<C-j>"] = { ":ToggleTerm size=30 direction=horizontal<cr>", desc = "Toggle terminal" },
    ["<leader>;"] = { ":2ToggleTerm size=30 direction=horizontal<cr>", desc = "Open terminal with tab" },
    ["[x"] = { ":GitConflictPrevConflict<cr>", desc = "Previous Git conflict" },
    ["]x"] = { ":GitConflictNextConflict<cr>", desc = "Next Git conflict" },
    ["cx"] = { ":GitConflictListQf<cr>", desc = "List Git conflicts" },
    ["co"] = { ":GitConflictChooseOurs<cr>", desc = "Git conflict - choose ours" },
    ["ct"] = { ":GitConflictChooseTheirs<cr>", desc = "Git conflict - choose theirs" },
    ["cb"] = { ":GitConflictChooseBoth<cr>", desc = "Git conflict - choose both" },
    ["c0"] = { ":GitConflictChooseNone<cr>", desc = "Git conflict - choose none" },
    ["<leader>U"] = { ":UndotreeToggle<cr>", desc = "Toggle undo history" },
    ["<leader>gg"] = { ":Git<cr>", desc = "Open Git" },
    ["<leader>m"] = { ":MarkdownPreview<cr>", desc = "Show markdown preview" },
    ["<leader>z"] = { ":ZenMode<cr>", desc = "Toggle Zen mode" },
    ["<leader>uR"] = { ":CellularAutomaton make_it_rain<cr>", desc = "Make it rain" },
    ["<leader>uG"] = { ":CellularAutomaton game_of_life<cr>", desc = "Game of life" },
    ["<leader>fs"] = { ":Silicon<cr>", desc = "Save image" },
    ["<leader>fM"] = { ":Telescope media_files<cr>", desc = "Find media files" },
  },
  i = {
    ["<C-s>"] = { "<esc>:w!<cr>", desc = "Save file" },
    ["<C-q>"] = { "<esc>:qa!<cr>", desc = "Exit" },
  },
  v = {
    ["<leader>p"] = { '"0p', desc = "Paste without replacing the buffer" },
    ["<C-r>"] = { '"hy:%s/<C-r>h//gc<left><left><left>', desc = "Replace" },
    ["<leader>s"] = { ":'<,'>Silicon<cr>", desc = "Save image" },
  },
  t = {
    ["<C-j>"] = { "<C-\\><C-N>", desc = "Switch to normal mode" },
  },
}

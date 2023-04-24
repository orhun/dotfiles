return {
  "stevearc/aerial.nvim",
  opts = {
    lazy = false,
    open_automatic = function(bufnr)
      -- Enforce a minimum line count
      return vim.api.nvim_buf_line_count(bufnr) > 25
        -- Enforce a minimum symbol count
        and require("aerial").num_symbols(bufnr) > 3
        -- A useful way to keep aerial closed when closed manually
        and not require("aerial").was_closed()
    end,
  },
}

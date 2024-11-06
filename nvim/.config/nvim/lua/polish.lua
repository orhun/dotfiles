-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
vim.filetype.add({
	extension = {
		foo = "fooscript",
	},
	filename = {
		["Foofile"] = "fooscript",
	},
	pattern = {
		["~/%.config/foo/.*"] = "fooscript",
	},
})

vim.api.nvim_create_autocmd("BufRead", {
	desc = "Disable diagnostics/formatting for specific files",
	pattern = "*PKGBUILD,*APKBUILD",
	callback = function()
		vim.o.filetype = "sh"
		vim.g.ui_notifications_enabled = false
		require("astrocore.toggles").diagnostics()
		require("astrocore.toggles").diagnostics()
		require("astrocore.toggles").diagnostics()
		require("astrolsp.toggles").buffer_autoformat()
		vim.g.ui_notifications_enabled = true
	end,
})

vim.cmd([[
      autocmd BufWinEnter,WinEnter term://* startinsert
    ]])

function _G.set_terminal_keymaps()
	local opts = { noremap = true }
	vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

local function log_diagnostics()
	-- local file_path = vim.fn.stdpath("data") .. "/diagnostics_log.txt"
	local file_path = "/home/orhun/diagnostics_log.txt"
	local current_total = 0

	local file = io.open(file_path, "r")
	if file then
		local content = file:read("*a")
		current_total = tonumber(content) or 0
		file:close()
	end

	local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })

	local new_total = current_total + errors

	file = io.open(file_path, "w")
	if file then
		file:write(tostring(new_total))
		file:close()
	else
		print("Failed to open diagnostics log file")
	end
end

local timer = vim.loop.new_timer()
timer:start(0, 10000, vim.schedule_wrap(log_diagnostics))

vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		if timer then
			timer:stop()
			timer:close()
		end
	end,
})

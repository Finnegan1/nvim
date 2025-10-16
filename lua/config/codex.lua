require("codex").setup({
		border = 'rounded',
		width = 0.8,
		height = 0.8,
		model = nil,
		autoinstall = true,
		keymaps = {
			toggle = nil, -- Keybind to toggle Codex window (Disabled by default, watch out for conflicts)
			quit = '<C-g>', -- Keybind to close the Codex window (default: Ctrl + q)
		},
})

-- Codex keybindings
vim.api.nvim_set_keymap(
	"n",
	"<leader>ago",
	":Codex<CR>",
	{ noremap = true, silent = true, desc = "Open Codex" }
)
require("claude-code").setup({
	window = {
		position = "float",
		float = {
			width = "90%",      -- Take up 90% of the editor width
			height = "90%",     -- Take up 90% of the editor height
			row = "center",     -- Center vertically
			col = "center",     -- Center horizontally
			relative = "editor",
			border = "double",  -- Use double border style
		},
	},
	keymaps = {
		toggle = {
		  normal = false,       -- Normal mode keymap for toggling Claude Code, false to disable
		  terminal = false,     -- Terminal mode keymap for toggling Claude Code, false to disable
		  variants = {
			continue = false, -- Normal mode keymap for Claude Code with continue flag
			verbose = false,  -- Normal mode keymap for Claude Code with verbose flag
		  },
		},
		window_navigation = true, -- Enable window navigation keymaps (<C-h/j/k/l>)
		scrolling = true,         -- Enable scrolling keymaps (<C-f/b>) for page up/down
	  },
})

vim.api.nvim_set_keymap(
	"n",
	"<leader>aco",
	":ClaudeCode<CR>",
	{ noremap = true, silent = true, desc = "Open Claude Code" }
)

vim.api.nvim_set_keymap(
	"n",
	"<leader>acc",
	":ClaudeCodeContinue<CR>",
	{ noremap = true, silent = true, desc = "Open Claude Code with continue flag" }
)

vim.api.nvim_set_keymap(
	"n",
	"<leader>acr",
	":ClaudeCodeResume<CR>",
	{ noremap = true, silent = true, desc = "Open Claude Code with resume flag" }
)
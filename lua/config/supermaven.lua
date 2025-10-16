require("supermaven-nvim").setup({
	keymaps = {
	  accept_suggestion = "<Tab>",
	  clear_suggestion = "<C-]>",
	  accept_word = "<C-j>",
	},
	color = {
	  suggestion_color = "#ffffff",
	  cterm = 244,
	},
	log_level = "info",
	disable_inline_completion = false, -- we want to use it with cmp
})
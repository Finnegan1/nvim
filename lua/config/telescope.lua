local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
  defaults = {
	mappings = {
	  i = {
		["<C-k>"] = actions.move_selection_previous,
		["<C-j>"] = actions.move_selection_next,
		["<C-q>"] = actions.send_to_qflist,
	  },
	  n = {
		["<C-j>"] = actions.move_selection_next,
		["<C-k>"] = actions.move_selection_previous,
	  },
	},
  }
})

telescope.load_extension("fzf");
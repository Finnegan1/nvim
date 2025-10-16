-- Treesitter: Better syntax highlighting
return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"vrischmann/tree-sitter-templ",
	},
	build = ":TSUpdate",
	config = function()
		require("config.treesitter")
	end,
}

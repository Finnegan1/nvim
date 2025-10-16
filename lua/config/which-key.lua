

require("which-key").setup({})

require("which-key").add({
	{ "<leader>h", group = "Harpoon" },
	{ "<leader>d", group = "Diagnostics" },
	{ "<leader>l", group = "LSP" },
	{ "<leader>a", group = "AI" },
	{ "<leader>ac", group = "Claude Code" },
	{ "<leader>ag", group = "GPT" },
})
-- LSP Configuration and Mason installer
return {
	-- LSP Config
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("config.lsp")
		end,
	},

	-- Mason: LSP/DAP/Linter installer
	{
		"williamboman/mason.nvim",
		version = "^1.0.0", -- Pin to v1.x to avoid compatibility issues
	},

	-- Mason-LSPConfig bridge
	{
		"williamboman/mason-lspconfig.nvim",
		version = "^1.0.0", -- Pin to v1.x to avoid compatibility issues
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("config.mason")
		end,
	},
	-- Autocompletion framework
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer", -- suggestions based on the current buffer
			"hrsh7th/cmp-path", -- path autocompletion
			"hrsh7th/cmp-nvim-lsp", -- LSP support
			"onsails/lspkind-nvim", -- enhance completion menu appearance
			"L3MON4D3/LuaSnip", -- snippet engine
			"saadparwaiz1/cmp_luasnip", -- integrate LuaSnip with cmp
			"rafamadriz/friendly-snippets", -- collection of snippets
			"kristijanhusak/vim-dadbod-completion", -- database completion source
			"supermaven-inc/supermaven-nvim", -- AI completion source
		},
		config = function()
			require("config.cmp")
		end,
	},
}

return {
    {
        "benlubas/molten-nvim",
        version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
		ft = { "python", "markdown", "quarto", "json", "ipynb" }, -- Added 'json' for .ipynb files
		dependencies = {
			"3rd/image.nvim",
			{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", lazy=true },
			{ "nvim-tree/nvim-web-devicons", lazy=true }, -- Optional: for icons
		  },
        build = ":UpdateRemotePlugins",
        init = function()
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_output_win_max_height = 20

			vim.g.molten_auto_open_output = true -- Show output automatically
			-- vim.g.molten_virt_text_output = true -- Use virtual text for output (alternative)
        end,
		config = function()
			require("config.molten")
		end,
    },
    {
		-- dependencies:
		-- brew install imagemagick
        "3rd/image.nvim",
        opts = {
            backend = "kitty", -- whatever backend you would like to use
            max_width = 100,
            max_height = 12,
            max_height_window_percentage = math.huge,
            max_width_window_percentage = math.huge,
            window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
            window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        },
    },
	{
		"GCBallesteros/jupytext.nvim",
		config = function()
			require("config.jupytext")
		end,
		lazy = false,
	},
	{
		"quarto-dev/quarto-nvim",
		dependencies = {
		  "jmbuhr/otter.nvim",
		  "nvim-treesitter/nvim-treesitter",
		},
		config = function()
		  require("config.quarto")
		end,
	  },
}

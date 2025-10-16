return {
	"greggh/claude-code.nvim",
	dependencies = {
	  "nvim-lua/plenary.nvim",
	},
	config = function()
		require("config.claude-code")
	end
  }
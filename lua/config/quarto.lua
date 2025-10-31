local quarto = require('quarto')

quarto.setup{
	debug = false,
	closePreviewOnExit = true,
	lspFeatures = {
	  enabled = true,
	  chunks = "curly",
	  languages = { "r", "python", "julia", "bash", "html" },
	  diagnostics = {
		enabled = true,
		triggers = { "BufWritePost" },
	  },
	  completion = {
		  enabled = true,
	  },
	},
	codeRunner = {
	  enabled = true,
	  default_method = "molten", -- "molten", "slime", "iron" or <function>
	  ft_runners = {
		  python = "molten",
		  quarto = "molten",
	  },
	  never_run = { 'yaml' }, -- filetypes which are never sent to a code runner
	},
}

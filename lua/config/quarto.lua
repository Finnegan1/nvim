local quarto = require('quarto')
local runner = require('quarto.runner')

-- Custom code runner that ensures Molten is ready
local function run_with_molten(code, lang)
  -- Ensure Molten is initialized
  if vim.fn.exists(":MoltenInit") == 2 then
    -- Check if buffer is initialized
    if not vim.b.molten_initialized then
      vim.cmd("MoltenInit")
      vim.b.molten_initialized = true
    end
  end
  
  -- Now run the code through Molten
  return require("molten.runtime").run_with_molten(code, lang)
end

quarto.setup{
	debug = false,
	closePreviewOnExit = true,
	lspFeatures = {
	  enabled = true,
	  chunks = "all",
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
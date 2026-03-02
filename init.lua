if vim.g.vscode then
	require("core.vscode")
	print("VSCode extension")
	return
end

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
require("core.mapping")
require("core.diagnostics")
require("core.options")


require("config.lazy")
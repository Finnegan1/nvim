-- Formatter configuration
local util = require("formatter.util")

-- Custom format function for templ files
Custom_format = function()
	if vim.bo.filetype == "templ" then
		local bufnr = vim.api.nvim_get_current_buf()
		local filename = vim.api.nvim_buf_get_name(bufnr)
		local cmd = "templ fmt " .. vim.fn.shellescape(filename)

		vim.fn.jobstart(cmd, {
			on_exit = function()
				-- Reload the buffer only if it's still the current buffer
				if vim.api.nvim_get_current_buf() == bufnr then
					vim.cmd("e!")
				end
			end,
		})
	else
		vim.lsp.buf.format()
	end
end

require("formatter").setup({
	logging = true,
	log_level = vim.log.levels.WARN,
	filetype = {
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
		javascript = {
			require("formatter.filetypes.javascript").prettier,
		},
		javascriptreact = {
			require("formatter.filetypes.javascriptreact").prettier,
		},
		typescript = {
			require("formatter.filetypes.typescript").prettier,
		},
		typescriptreact = {
			require("formatter.filetypes.typescriptreact").prettier,
		},
		python = {
			require("formatter.filetypes.python").autopep8,
		},
		go = {
			require("formatter.filetypes.go").gofmt,
		},
		json = {
			require("formatter.filetypes.json").prettier,
		},
		yaml = {
			require("formatter.filetypes.yaml").prettier,
		},
		html = {
			require("formatter.filetypes.html").prettier,
		},
		css = {
			require("formatter.filetypes.css").prettier,
		},
		markdown = {
			require("formatter.filetypes.markdown").prettier,
		},
		rust = {
			require("formatter.filetypes.rust").rustfmt,
		},
		xml = {
			function()
				return {
					exe = "xmlformat",
					args = {},
					stdin = true,
				}
			end,
		},
		zsh = {
			require("formatter.filetypes.zsh").beautysh,
		},
		["*"] = {
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
	},
})

-- Format keymap
vim.keymap.set("n", "<leader>f", Custom_format, { noremap = true, silent = true, desc = "Format File" })

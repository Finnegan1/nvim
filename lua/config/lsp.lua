-- LSP Configuration
local cmp_nvim_lsp = require("cmp_nvim_lsp")

-- Define templ filetype
vim.filetype.add({ extension = { templ = "templ" } })

-- LSP keymaps (set on LspAttach event)
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		print("LSP started.")

		local opts = { buffer = ev.buf, noremap = true, silent = true }

		vim.keymap.set(
			"n",
			"gr",
			"<cmd>Telescope lsp_references<CR>",
			vim.tbl_extend("force", opts, { desc = "Show LSP references" })
		)
		vim.keymap.set(
			"n",
			"gd",
			"<cmd>Telescope lsp_definitions<CR>",
			vim.tbl_extend("force", opts, { desc = "Show LSP definition" })
		)
		vim.keymap.set(
			"n",
			"gi",
			"<cmd>Telescope lsp_implementations<CR>",
			vim.tbl_extend("force", opts, { desc = "Show LSP implementations" })
		)
		vim.keymap.set(
			"n",
			"gt",
			"<cmd>Telescope lsp_type_definitions<CR>",
			vim.tbl_extend("force", opts, { desc = "Show LSP type definition" })
		)
		vim.keymap.set(
			{ "n", "v" },
			"<leader>da",
			vim.lsp.buf.code_action,
			vim.tbl_extend("force", opts, { desc = "See available code actions" })
		)
		vim.keymap.set(
			"n",
			"<leader>lr",
			vim.lsp.buf.rename,
			vim.tbl_extend("force", opts, { desc = "Smart rename" })
		)
		vim.keymap.set(
			"n",
			"K",
			vim.lsp.buf.hover,
			vim.tbl_extend("force", opts, { desc = "Show documentation for what is under cursor" })
		)
		vim.keymap.set(
			"n",
			"<leader>ln",
			"<cmd>LspRestart<CR>",
			vim.tbl_extend("force", opts, { desc = "Restart LSP" })
		)
	end,
})

-- Set up autocompletion capabilities
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
vim.diagnostic.config({
	signs = {
		text = signs,
	},
})

-- Configure language servers
local servers = {
	html = {
		capabilities = capabilities,
		filetypes = { "html", "templ" },
	},
	htmx = {
		capabilities = capabilities,
		filetypes = { "html", "templ" },
	},
	ts_ls = {
		capabilities = capabilities,
	},
	cssls = {
		capabilities = capabilities,
	},
	tailwindcss = {
		capabilities = capabilities,
		filetypes = { "html", "templ", "astro", "javascript", "typescript", "javascriptreact", "typescriptreact", "react" },
		init_options = {
			userLanguages = {
				html = "html",
				templ = "html",
				astro = "html",
				javascript = "javascript",
				typescript = "typescript",
				javascriptreact = "javascript",
				typescriptreact = "typescript",
				react = "javascript",
			},
		},
	},
	pyright = {
		capabilities = capabilities,
		settings = {
			python = {
				analysis = {
					autoSearchPaths = true,
					useLibraryCodeForTypes = true,
					autoImportCompletions = true,
					typeCheckingMode = "basic",
				},
			},
		},
	},
	lua_ls = {
		capabilities = capabilities,
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
			},
		},
	},
	gopls = {
		capabilities = capabilities,
		cmd = { "gopls" },
		filetypes = { "go", "gomod", "gowork", "gotmpl" },
		root_markers = { "go.work", "go.mod", ".git" },
		settings = {
			gopls = {
				completeUnimported = true,
				usePlaceholders = true,
				analyses = {
					unusedparams = true,
				},
			},
		},
	},
	bashls = {
		capabilities = capabilities,
		filetypes = { "sh", "bash" },
	},
	jsonls = {
		capabilities = capabilities,
		filetypes = { "json", "jsonc" },
	},
	dockerls = {
		capabilities = capabilities,
		filetypes = { "dockerfile" },
	},
}

-- Apply configurations and enable servers using new vim.lsp.config API
for server, config in pairs(servers) do
	vim.lsp.config(server, config)
	vim.lsp.enable(server)
end

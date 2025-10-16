local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

-- load snippets from plugins (e.g. friendly-snippets)
require("luasnip.loaders.from_vscode").lazy_load()

vim.opt.completeopt = "menu,menuone,noselect"

-- Configure lspkind for Supermaven icon
lspkind.init({
	symbol_map = {
		Supermaven = "",
	},
})

-- Set highlight for Supermaven completion items
vim.api.nvim_set_hl(0, "CmpItemKindSupermaven", { fg = "#6CC644" })

cmp.setup({
	completion = {
		autocomplete = { cmp.TriggerEvent.TextChanged },
		keyword_length = 1,
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<S-CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.close(),
	}),
	sources = {
		{ name = "supermaven", priority = 1000 },
		{ name = "nvim_lsp", priority = 900 },
		{ name = "luasnip", priority = 750 },
		{ name = "buffer", priority = 500 },
		{ name = "path", priority = 250 },
		{ name = "vim-dadbod-completion", priority = 700 },
	},
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol",
			maxwidth = 50,
			symbol_map = { Supermaven = "" },
		}),
	},
	window = {
		documentation = {
			border = "rounded",
		},
	},
})

local autocomplete_group = vim.api.nvim_create_augroup("vimrc_autocompletion", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "sql", "mysql", "plsql" },
	callback = function()
		cmp.setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
	end,
	group = autocomplete_group,
})

vim.opt.wildignore = {
	"*.o",
	"*.obj,*~",
	"*.git*",
	"*.meteor*",
	"*vim/backups*",
	"*sass-cache*",
	"*mypy_cache*",
	"*__pycache__*",
	"*cache*",
	"*logs*",
	"*node_modules*",
	"**/node_modules/**",
	"*DS_Store*",
	"*.gem",
	"log/**",
	"tmp/**",
}

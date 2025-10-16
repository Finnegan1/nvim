require("Comment").setup({
	mappings = {
		basic = false,
		extra = false,
	},
})

-- Add custom key mappings to make commenting behave like VSCode
-- Toggle line comment: Shift+Cmd+7 (Mac style)
vim.keymap.set("n", "<S-D-7>", function()
require("Comment.api").toggle.linewise.current()
end, { noremap = true, silent = true, desc = "Toggle comment (Shift+Cmd+7)" })

vim.keymap.set("v", "<S-D-7>", function()
local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
vim.api.nvim_feedkeys(esc, 'nx', false)
require("Comment.api").toggle.linewise(vim.fn.visualmode())
end, { noremap = true, silent = true, desc = "Toggle comment (Shift+Cmd+7) visual" })
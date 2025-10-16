print("mapping")
--change leader key to space
vim.g.mapleader = " "
vim.o.timeoutlen = 500
vim.g.maplocalleader = "\\"

--back navigation
vim.keymap.set("n", "-", vim.cmd.Ex)


--Move cursor between Panes
-- move cursor to the left pane
vim.api.nvim_set_keymap('n', 'ª', '<C-w>h', { noremap = true, silent = true })
-- move cursor to the right pane
vim.api.nvim_set_keymap('n', '@', '<C-w>l', { noremap = true, silent = true })


--- Move whole Line
-- move current line one up
vim.api.nvim_set_keymap('n', '∆', ':m .-2<CR>==', { noremap = true, silent = true })
-- move urrent line one down
vim.api.nvim_set_keymap('n', 'º', ':m .+<CR>==', { noremap = true, silent = true })


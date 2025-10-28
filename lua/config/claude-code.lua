require("claudecode").setup({})

vim.keymap.set("n", "<leader>act", "<cmd>ClaudeCode<cr>", { noremap = true, silent = true, desc = "Toggle Claude Code" })
vim.keymap.set("n", "<leader>acc", "<cmd>ClaudeCode --continue<cr>", { noremap = true, silent = true, desc = "Open Claude Code with continue flag" })
vim.keymap.set("n", "<leader>acr", "<cmd>ClaudeCode --resume<cr>", { noremap = true, silent = true, desc = "Open Claude Code with resume flag" })
vim.keymap.set("n", "<leader>acb", "<cmd>ClaudeCodeAdd %<cr>", { noremap = true, silent = true, desc = "Add current buffer" })
vim.keymap.set("n", "<leader>acs", "<cmd>ClaudeCodeSend<cr>", { noremap = true, silent = true, desc = "Send to Claude" })
vim.keymap.set("n", "<leader>acm", "<cmd>ClaudeCodeSelectModel<cr>", { noremap = true, silent = true, desc = "Select Claude model" })
vim.keymap.set("n", "<leader>acp", "<cmd>ClaudeCodeTreeAdd<cr>", { noremap = true, silent = true, desc = "Add file" })
vim.keymap.set("n", "<leader>acf", "<cmd>ClaudeCodeFocus<cr>", { noremap = true, silent = true, desc = "Focus Claude" })

vim.keymap.set("n", "<leader>acx", "<cmd>ClaudeCodeClose<cr>", { noremap = true, silent = true, desc = "Close Claude Code" })

-- Diff management
vim.keymap.set("n", "<leader>aca", "<cmd>ClaudeCodeDiffAccept<cr>", { noremap = true, silent = true, desc = "Accept diff" })
vim.keymap.set("n", "<leader>acd", "<cmd>ClaudeCodeDiffDeny<cr>", { noremap = true, silent = true, desc = "Deny diff" })

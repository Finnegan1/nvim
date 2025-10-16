
vim.o.updatetime = 100
vim.api.nvim_create_autocmd({ "CursorHold" }, {
    pattern = "*",
    callback = function()
        for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
            if vim.api.nvim_win_get_config(winid).zindex then
                return
            end
        end
        vim.diagnostic.open_float({
            scope = "cursor",
            focusable = false,
            close_events = {
                "CursorMoved",
                "CursorMovedI",
                "BufHidden",
                "InsertCharPre",
                "WinLeave",
            },
        })
    end
})

vim.api.nvim_set_keymap(
    'n',
    '<leader>dp',
    '<cmd>lua vim.diagnostic.goto_prev()<CR>',
    { noremap = true, silent = true, desc = "Go to previous diagnostic" }
)

vim.api.nvim_set_keymap(
    'n',
    '<leader>dn',
    '<cmd>lua vim.diagnostic.goto_next()<CR>',
    { noremap = true, silent = true, desc = "Go to next diagnostic" }
)

vim.api.nvim_set_keymap(
    'n', 
    '<leader>dw',
    '<cmd>Telescope diagnostics<CR>',
    { noremap = true, silent = true, desc = "Open workspace diagnostics" }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader>dd",
    "<cmd>Telescope diagnostics bufnr=0<CR>",
    { noremap = true, silent = true, desc = "Show buffer diagnostics" }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader>ds",
    "<cmd>lua vim.diagnostic.open_float()<CR>",
    { noremap = true, silent = true, desc = "Show line diagnostics" }
)
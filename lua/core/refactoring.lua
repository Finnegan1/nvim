
function rename_var()
  vim.lsp.buf.rename()
end

-- Mapping <leader>rr to the rename function
vim.api.nvim_set_keymap('n', '<leader>rr', '<cmd>lua rename_var()<CR>', { noremap = true, silent = true })

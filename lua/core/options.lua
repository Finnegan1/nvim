-- appearance
vim.api.nvim_set_hl(0, 'FloatBorder', {bg='#3B4252', fg='#5E81AC'})
vim.api.nvim_set_hl(0, 'NormalFloat', {bg='#3B4252'})
vim.api.nvim_set_hl(0, 'TelescopeNormal', {bg='#3B4252'})
vim.api.nvim_set_hl(0, 'TelescopeBorder', {bg='#3B4252'})



--- line numbers
-- Enable line numbers
vim.opt.number = true
-- Enable relative line numbers
vim.opt.relativenumber = true


--- tab size
vim.opt.tabstop = 2       -- A tab is shown (and occupies) as 2 spaces in the editor
vim.opt.shiftwidth = 2    -- Indent/outdent by 2 spaces
vim.opt.expandtab = true  -- Convert tabs to spaces


-- maximal text width
vim.api.nvim_set_option('textwidth', 500)


-- Enable wrapping
vim.opt.wrap = false
-- Enable soft line wrapping without breaking words
vim.opt.linebreak = true


-- Display the wrapped part of a line differently (e.g., with a prefix)
--vim.opt.showbreak = string.rep(' ', 3)  -- Use two spaces as a prefix, adjust as needed


--copy with y to normalnormal  computer clipboard
vim.api.nvim_set_option("clipboard","unnamed")

-- disable virtual text diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
 vim.lsp.diagnostic.on_publish_diagnostics, {
   underline = true,
   virtual_text = false
 }
)

-- Swap file and buffer handling to prevent E325 attention errors
vim.opt.swapfile = false      -- Disable swap files completely
vim.opt.backup = false        -- Disable backup files
vim.opt.writebackup = false   -- Disable writebackup
vim.opt.autoread = true       -- Automatically read files when changed outside Neovim
vim.opt.autowrite = true      -- Automatically write files when switching buffers

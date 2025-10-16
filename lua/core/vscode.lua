local ok_vscode, vscode = pcall(require, "vscode")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

if vim.g.vscode_clipboard then
  vim.g.clipboard = vim.g.vscode_clipboard
end

local function map_vscode(lhs, command, desc)
  if not ok_vscode then
    return
  end

  vim.keymap.set("n", lhs, function()
    vscode.action(command)
  end, { silent = true, desc = desc })
end

map_vscode("<leader>ff", "workbench.action.quickOpen", "VSCode Quick Open")
map_vscode("<leader>fs", "workbench.action.findInFiles", "VSCode Find in Files")
map_vscode("<leader>fr", "editor.action.startFindReplaceAction", "VSCode Find/Replace")
map_vscode("<leader>dn", "editor.action.marker.next", "Next Diagnostic")
map_vscode("<leader>db", "editor.action.marker.prev", "Previous Diagnostic")
map_vscode("<leader>dv", "workbench.actions.view.problems", "Open Problems Panel")
map_vscode("<leader>rr", "editor.action.rename", "Rename Symbol")

if ok_vscode then
  vim.notify = vscode.notify
end

vim.diagnostic.config({
  virtual_text = false,
  update_in_insert = false,
})

return {}


require('codecompanion').setup {
  display = {
    diff = {
      enabled = true,
    },
  },
  strategies = {
    chat = {
      adapter = "openrouter",
      keymaps = {
        send = {
          modes = { n = "<C-s>", i = "<C-s>" },
          opts = {},
        },
        close = {
          modes = { n = "<C-c>", i = "<C-c>" },
          opts = {},
        },
      },
    },
    inline = {
      adapter = "openrouter",
    },
  },
  adapters = {
    openrouter = function()
      return require("adapters.openrouter")
    end,
    acp = {
      claude_code = function()
        return require("codecompanion.adapters").extend("claude_code", {})
      end,
      codex = function()
        return require("codecompanion.adapters").extend("codex", {
          defaults = {
            auth_method = "chatgpt", -- "openai-api-key"|"codex-api-key"|"chatgpt"
          },
        })
      end,
    },
  },
}
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

-- Model selection is now handled through :CodeCompanionChat settings
-- vim.cmd([[cab cc CodeCompanion]])

vim.keymap.set('n', '<leader>aat', ':CodeCompanionChat Toggle<cr>', { silent = true, desc = 'toggle chat' })
vim.keymap.set('n', '<leader>aaa', ':CodeCompanionActions<cr>', { silent = true, desc = 'show actions' })
vim.keymap.set({'n', 'v'}, '<D-k>', function()
  -- print for debugging
  print("CodeCompanion inline assistant")
  vim.ui.input({ prompt = 'CodeCompanion Prompt: ' }, function(input)
    if input and input ~= '' then
      vim.cmd('CodeCompanion ' .. input)
    end
  end)
end, { silent = true, desc = 'inline assistant' })

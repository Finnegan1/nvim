local function read_env(name)
  local value = os.getenv(name)
  if value and value ~= '' then
    return value
  end
end

local openrouter_creator = require('adapters/openrouterV2')
local standard_inline = read_env('CODECOMPANION_INLINE_MODEL') or 'anthropic/claude-haiku-4.5'

require('codecompanion').setup {
  adapters = {
    http = {
      openrouter_claude_sonnet_4_5 = openrouter_creator('anthropic/claude-sonnet-4.5'),
      openrouter_x_ai_grok_code_fast_1 = openrouter_creator('x-ai/grok-code-fast-1'),
      openrouter_anthropic_claude_haiku_4_5 = openrouter_creator('anthropic/claude-haiku-4.5'),
      openrouter_standard_inline = openrouter_creator(standard_inline),
    },
    acp = {
      claude_code = function()
        return require('codecompanion.adapters').extend('claude_code', {
          env = {
            CLAUDE_CODE_OAUTH_TOKEN = read_env('CLAUDE_CODE_OAUTH_TOKEN'),
            ANTHROPIC_API_KEY = read_env('ANTHROPIC_API_KEY'),
          },
        })
      end,
      codex = function()
        return require('codecompanion.adapters').extend('codex', {
          defaults = {
            auth_method = read_env('CODECOMPANION_CODEX_AUTH') or 'chatgpt',
          },
          env = {
            AGENT_ROUTER_TOKEN = read_env('AGENT_ROUTER_TOKEN'),
            OPENAI_API_KEY = read_env('OPENAI_API_KEY'),
          },
        })
      end,
    },
  },
  display = {
    chat = {
      intro_message = 'Cursor-style CodeCompanion ✨ – press ? inside for help',
      show_header_separator = false,
      fold_reasoning = true,
      window = {
        layout = 'vertical',
        position = 'right',
        border = 'rounded',
        width = 0.34,
        full_height = true,
        sticky = true,
      },
    },
    diff = {
      enabled = true,
    },
    inline = {
      layout = 'vertical',
    },
  },
  strategies = {
    chat = {
      adapter = 'openrouter_x_ai_grok_code_fast_1',
      keymaps = {
        send = {
          modes = { i = '<C-s>', n = '<CR>' },
        },
        close = {
          modes = { i = '<C-c>', n = '<C-c>' },
        },
      },
    },
    inline = {
      adapter = 'openrouter_standard_inline',
      keymaps = {
        accept_change = {
          modes = { n = 'gda' },
        },
        reject_change = {
          modes = { n = 'gdr' },
        },
        always_accept = {
          modes = { n = 'gdy' },
        },
      },
    },
  },
}

local function inline_prompt(opts)
  opts = opts or {}

  local ok, prompt = pcall(function()
    return vim.fn.input(opts.prompt or 'CodeCompanion prompt: ')
  end)
  
  if not ok or not prompt or prompt == '' then
    return
  end

  local cleaned = prompt:gsub('\n', ' ')
  local mode = vim.fn.mode()
  local in_visual = mode:match('[vV\22]') ~= nil

  local parts = {}

  local include_buffer = opts.include_buffer
  if include_buffer == nil then
    include_buffer = not in_visual
  end

  if include_buffer then
    table.insert(parts, '#{buffer}')
  end

  if opts.variables then
    for _, variable in ipairs(opts.variables) do
      table.insert(parts, variable)
    end
  end

  table.insert(parts, cleaned)

  local command = table.concat(parts, ' ')

  if in_visual then
    vim.cmd('normal! \\<Esc>')
    vim.cmd("'<,'>CodeCompanion " .. command)
  else
    vim.cmd('CodeCompanion ' .. command)
  end
end

vim.keymap.set('n', '<leader>ac', '<cmd>CodeCompanionChat Toggle<cr>', { silent = true, desc = 'Toggle CodeCompanion chat' })
vim.keymap.set('n', '<leader>ao', function()
  require('codecompanion').chat({ focus = true })
end, { silent = true, desc = 'Open CodeCompanion chat' })
vim.keymap.set({ 'n', 'v' }, '<leader>as', '<cmd>CodeCompanionChat Add<cr>', { silent = true, desc = 'Share selection with chat' })
vim.keymap.set('n', '<leader>aa', '<cmd>CodeCompanionActions<cr>', { silent = true, desc = 'CodeCompanion actions palette' })

-- Inline assistant (OpenRouter only)
vim.keymap.set({ 'n', 'v' }, '<leader>ai', function()
  inline_prompt()
end, { desc = 'Inline assistant', silent = true })

-- Chat-only adapters
vim.keymap.set('n', '<leader>aC', function()
  require('codecompanion').chat({ adapter = 'claude_code', focus = true })
end, { desc = 'Chat with Claude Code', silent = true })

vim.keymap.set('n', '<leader>aX', function()
  require('codecompanion').chat({ adapter = 'codex', focus = true })
end, { desc = 'Chat with Codex', silent = true })

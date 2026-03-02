# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a modular Neovim configuration using **lazy.nvim** for plugin management. The config is optimized for:
- Full-stack web development (TypeScript, Go, Python)
- Scientific computing with Jupyter/Quarto notebooks
- AI-assisted development with multiple LLM backends
- Database work with SQL integration

**Total**: ~2,157 lines of Lua across 45 files

## Architecture

### Directory Structure
```
~/.config/nvim/
├── init.lua                    # Entry point - loads core modules
├── lua/
│   ├── core/                   # Core settings (options, mappings, diagnostics)
│   ├── config/                 # Plugin-specific configurations
│   ├── plugins/                # Plugin specifications (lazy.nvim format)
│   └── adapters/               # Custom AI adapters (OpenRouter, etc.)
└── lazy-lock.json              # Plugin version lock file
```

### Loading Sequence
1. `init.lua` → VSCode mode check, then loads:
   - `core/mapping` → Leader keys and global keymaps
   - `core/diagnostics` → LSP diagnostic configuration
   - `core/options` → Editor settings
   - `config/lazy` → Bootstrap lazy.nvim and load all plugins

2. Plugins are lazy-loaded based on events/filetypes/commands
3. Each plugin has two files:
   - `plugins/xxx.lua` - Plugin spec with lazy loading config
   - `config/xxx.lua` - Actual plugin configuration

### Key Architectural Patterns

**Plugin Declaration Pattern:**
```lua
-- plugins/example.lua
{
  "user/plugin",
  event = "BufReadPre",  -- Lazy load trigger
  config = function() require("config.example") end
}
```

**Custom Adapter Pattern:**
- `lua/adapters/openrouterV2.lua` - Factory function for AI model adapters
- Returns a function that creates an OpenRouter adapter for a given model
- Used by CodeCompanion for multiple AI backends

## Development Commands

### Plugin Management
```bash
# Update all plugins (inside Neovim)
:Lazy update

# Sync plugins with lazy-lock.json
:Lazy sync

# Check plugin status
:Lazy
```

### LSP Commands
```vim
" Inside Neovim - LSP attached keymaps:
gr              " Show LSP references (Telescope)
gd              " Go to definition (Telescope)
gi              " Show implementations (Telescope)
gt              " Show type definition (Telescope)
K               " Show hover documentation
<leader>da      " Code actions
<leader>lr      " Smart rename
<leader>ln      " Restart LSP

" Diagnostic navigation (defined in core/diagnostics.lua):
<leader>dp      " Previous diagnostic
<leader>dn      " Next diagnostic
<leader>dw      " Workspace diagnostics (Telescope)
<leader>dd      " Buffer diagnostics (Telescope)
<leader>ds      " Show diagnostic float
```

### Testing & Validation
This is a Neovim config repository - there are no traditional tests. Validation is done by:
1. Starting Neovim: `nvim`
2. Checking for errors: `:checkhealth`
3. Verifying LSP: `:LspInfo`
4. Testing plugins manually

## Configuration Files

### Core Settings
- **`lua/core/options.lua`** - Editor options (tabs, line numbers, clipboard, Python venv)
- **`lua/core/mapping.lua`** - Global keymaps, leader keys (Space, backslash)
- **`lua/core/diagnostics.lua`** - LSP diagnostic display and navigation

### Important Plugin Configs
- **`lua/config/lsp.lua`** (172 lines) - LSP server configurations and keymaps
  - Configured servers: `ts_ls`, `html`, `css`, `tailwindcss`, `jsonls`, `dockerls`, `bashls`, `lua_ls`, `gopls`, `pyright`, `htmx`
  - Custom templ filetype support
  - Uses new `vim.lsp.config()` and `vim.lsp.enable()` API (Neovim 0.11+)

- **`lua/config/codecompanion.lua`** (155 lines) - AI integration
  - Multiple backends: OpenRouter (default), Claude Code, Codex
  - Custom inline prompt system
  - See CODECOMPANION_SETUP.md for environment variable requirements

- **`lua/config/cmp.lua`** - Autocompletion with source priority:
  1. Supermaven (AI, priority 1000)
  2. LSP (priority 900)
  3. LuaSnip (priority 750)
  4. vim-dadbod-completion (SQL, priority 700)
  5. Buffer (priority 500)
  6. Path (priority 250)

- **`lua/config/molten.lua`** - Jupyter notebook integration with image support
- **`lua/config/mason.lua`** - Automatic LSP/formatter installer
- **`lua/config/telescope.lua`** - Fuzzy finder with native fzf
- **`lua/config/treesitter.lua`** - Syntax highlighting with custom templ parser

### Custom Adapters
- **`lua/adapters/openrouterV2.lua`** - Factory for OpenRouter adapters
  - Extends `openai_compatible` adapter
  - Reads `OPENROUTER_API_KEY_CODECOMPANION` env var
  - Used to create multiple model-specific adapters

## AI Integration (CodeCompanion)

### Required Environment Variables
```bash
# OpenRouter (required for inline assistant and default chat)
export OPENROUTER_API_KEY_CODECOMPANION="your-key"

# Optional: Claude Code adapter
export CLAUDE_CODE_OAUTH_TOKEN="your-token"  # or
export ANTHROPIC_API_KEY="your-key"

# Optional: Codex adapter
export OPENAI_API_KEY="your-key"
export CODECOMPANION_CODEX_AUTH="chatgpt"

# Optional: Override default model
export CODECOMPANION_INLINE_MODEL="anthropic/claude-haiku-4.5"
```

### Available Keymaps
```vim
<leader>ai      " Inline assistant (diff-based edits) - OpenRouter only
<leader>ac      " Toggle chat sidebar
<leader>ao      " Open fresh chat
<leader>as      " Share selection with chat
<leader>aa      " Actions palette
<leader>aC      " Chat with Claude Code
<leader>aX      " Chat with Codex

" Inside inline diff:
gda             " Accept change
gdr             " Reject change
gdy             " Accept and enable auto mode

" Inside chat:
<C-s> or <CR>   " Send message
<C-c>           " Close chat
ga              " Switch adapter/model
?               " Show all keymaps
```

### Available Models
Default chat adapter: `x-ai/grok-code-fast-1`
Default inline adapter: `anthropic/claude-haiku-4.5`

Switch in chat with `ga` or set via environment variable.

## Important Notes

### Python Integration
- Python path points to `~/.config/nvim/.venv`
- Create venv: `python3 -m venv ~/.config/nvim/.venv`
- Install Jupyter kernel for Molten: `pip install jupyter ipykernel pynvim`

### Custom Filetypes
- **templ** - Go templating language, integrated with HTML/HTMX/Tailwind LSP
- Add new filetypes in `lua/config/lsp.lua` via `vim.filetype.add()`

### LSP Configuration Pattern
This config uses the new Neovim 0.11+ LSP API:
```lua
-- In lua/config/lsp.lua
for server, config in pairs(servers) do
  vim.lsp.config(server, config)  -- Register config
  vim.lsp.enable(server)          -- Enable server
end
```

**Do not use** `lspconfig.server.setup()` - it's replaced by the above pattern.

### Modifying the Configuration

**To add a new plugin:**
1. Create `lua/plugins/myname.lua` with lazy.nvim spec
2. Create `lua/config/myname.lua` with actual config
3. Reference config: `config = function() require("config.myname") end`
4. Add keymaps in config file or `core/mapping.lua`
5. Document in `lua/config/which-key.lua` if adding a keymap group

**To modify settings:**
- Editor options → `lua/core/options.lua`
- Global keymaps → `lua/core/mapping.lua`
- LSP behavior → `lua/config/lsp.lua`
- Completion behavior → `lua/config/cmp.lua`
- AI settings → `lua/config/codecompanion.lua`

**To add a new LSP server:**
1. Add to `servers` table in `lua/config/lsp.lua`
2. Include `capabilities = capabilities` for completion support
3. Mason will auto-install if server is in mason-lspconfig

**To add a custom AI adapter:**
1. Create factory function in `lua/adapters/yourname.lua`
2. Import and register in `lua/config/codecompanion.lua`
3. Follow OpenRouter pattern (see `openrouterV2.lua`)

### Colorscheme Behavior
- Uses Catppuccin with auto light/dark mode detection (macOS only)
- Polls system theme on startup and when Neovim gains focus
- To disable: modify `lua/plugins/colorcheme.lua`

### File Navigation
- **Telescope** - Main fuzzy finder (files, grep, LSP)
- **Harpoon v2** - Quick file marking and navigation
- **Snacks.nvim** - UI utilities (picker, input)

### Scientific Computing
- **Molten** - Jupyter kernel integration (Python/Quarto/Markdown)
- **Quarto** - R/Python/Julia notebook support with Otter LSP
- **Jupytext** - Convert between .py and .ipynb
- **image.nvim** - Display images inline (requires kitty/wezterm)

### Database Integration
- **vim-dadbod** - SQL database client
- **vim-dadbod-ui** - Interactive database UI
- SQL completion integrated into nvim-cmp

## Troubleshooting

### LSP not starting
```vim
:LspInfo                    " Check LSP status
:checkhealth                " Run health checks
:Mason                      " Check installed servers
```

### CodeCompanion errors
- Verify environment variables: `:lua print(vim.env.OPENROUTER_API_KEY_CODECOMPANION)`
- Check `:messages` for detailed error output
- See CODECOMPANION_SETUP.md for full setup guide

### Plugin issues
```vim
:Lazy                       " Check plugin status
:Lazy restore               " Restore from lazy-lock.json
:Lazy clean                 " Remove unused plugins
```

### Python/Molten issues
```vim
:checkhealth molten         " Check Molten setup
:UpdateRemotePlugins        " Rebuild remote plugin manifest
```

## File References

When working with this codebase, reference files using the pattern:
- LSP server configs: `lua/config/lsp.lua:78-165`
- AI keymaps: `lua/config/codecompanion.lua:135-154`
- Global options: `lua/core/options.lua`
- Plugin lazy loading: `lua/plugins/*.lua`

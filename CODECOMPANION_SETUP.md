# CodeCompanion Setup Guide

This document explains how to set up the required environment variables for CodeCompanion.nvim.

## Required Environment Variables

### OpenRouter (for inline assistance and chat)

You **must** set one of these environment variables:

```bash
export OPENROUTER_API_KEY_CODECOMPANION="your-api-key-here"
# OR
export OPENROUTER_API_KEY="your-api-key-here"

# Optional: Set your preferred default model
export CODECOMPANION_OPENROUTER_MODEL="anthropic/claude-sonnet-4.5"
```

To get an API key:
1. Visit https://openrouter.ai/
2. Sign up or log in
3. Go to API Keys section
4. Create a new API key
5. Add the export to your `~/.zshrc` or `~/.bashrc`

#### Available Models

The following models are available (defined in FALLBACK_MODELS):

**Top Tier Coding Models:**
- `anthropic/claude-sonnet-4.5` (default) - Best balance of quality and speed
- `google/gemini-2.5-flash` - Fast with hybrid reasoning
- `google/gemini-2.5-pro` - Best overall, more expensive

**Fast & Efficient:**
- `x-ai/grok-code-fast-1` - Code-focused with reasoning
- `x-ai/grok-4-fast` - Vision-enabled, very affordable
- `anthropic/claude-haiku-4.5` - Fast Claude model

**OpenAI Models:**
- `openai/gpt-5` - Latest GPT model
- `openai/gpt-5-mini` - Smaller, faster GPT

**Budget-Friendly:**
- `deepseek/deepseek-r1` - Open source reasoning model
- `deepseek/deepseek-v3` - Open source, very cheap

**Specialized Coding:**
- `qwen/qwen3-235b` - Strong coding performance
- `mistralai/devstral-small` - Code-focused

You can switch models in the chat by pressing `ga` or set a default with the environment variable above.

### Claude Code (optional, for chat only)

Choose one authentication method:

**Option 1: OAuth Token (recommended for Claude Pro users)**
```bash
# Run this command first:
claude setup-token

# Then export the token:
export CLAUDE_CODE_OAUTH_TOKEN="your-oauth-token"
```

**Option 2: API Key**
```bash
export ANTHROPIC_API_KEY="your-api-key"
```

Get an API key from: https://console.anthropic.com/settings/keys

### Codex (optional, for chat only)

```bash
export OPENAI_API_KEY="your-openai-api-key"
export AGENT_ROUTER_TOKEN="your-agent-router-token"  # Optional
export CODECOMPANION_CODEX_AUTH="chatgpt"  # or "openai-api-key" or "codex-api-key"
```

Requirements:
1. Install Codex CLI: `npm install -g @openai/codex`
2. Configure `~/.codex/config.toml` and `~/.codex/auth.json`

## Verify Setup

After setting environment variables:

1. **Restart your terminal** or source your shell config:
   ```bash
   source ~/.zshrc  # or ~/.bashrc
   ```

2. **Verify the variables are set**:
   ```bash
   echo $OPENROUTER_API_KEY_CODECOMPANION
   # Should print your API key
   ```

3. **Restart Neovim**

4. **Test inline assistant**:
   - Open a file
   - Press `<leader>ai`
   - Enter a prompt like "add a comment explaining this code"
   - You should see a diff appear

If you see an error about "choices" being nil, it means:
- Your API key is invalid or not set
- The OpenRouter API is returning an error
- Check `:messages` in Neovim for the actual error message

## Troubleshooting

### "attempt to index field 'choices' (a nil value)"

This error means the OpenRouter API request failed. Possible causes:

1. **API key not set**: Check environment variables
2. **Invalid API key**: Verify your key at https://openrouter.ai/
3. **No credits**: Check your OpenRouter account balance
4. **Model not available**: The default model might not be available

To debug:
1. Check `:messages` in Neovim for detailed error info
2. Try the chat first: `<leader>ac` to see if OpenRouter works at all
3. Verify API key is loaded: Run `:lua print(vim.env.OPENROUTER_API_KEY_CODECOMPANION)`

### "CodeCompanion API error" notification

The OpenRouter adapter now shows detailed error messages. Check the notification for:
- Authentication errors (invalid API key)
- Rate limiting errors (too many requests)
- Model errors (model not available)
- Credit errors (no balance)

## Usage

After setup:

- **`<leader>ai`** - Inline assistant (OpenRouter only)
- **`<leader>ac`** - Toggle chat sidebar
- **`<leader>ao`** - Open fresh chat
- **`<leader>as`** - Share selection with chat
- **`<leader>aa`** - Actions palette
- **`<leader>aC`** - Chat with Claude Code
- **`<leader>aX`** - Chat with Codex

Inside chat:
- `<C-s>` or `<CR>` - Send message
- `<C-c>` - Close chat
- `ga` - Switch adapter/model
- `?` - Show all keymaps

Inside inline diff:
- `gda` - Accept change
- `gdr` - Reject change
- `gdy` - Accept and enable auto mode


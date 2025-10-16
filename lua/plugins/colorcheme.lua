return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    -- Function to detect system theme (macOS)
    local function get_macos_theme()
      local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
      if not handle then return "light" end
      
      local result = handle:read("*a")
      handle:close()
      
      if result:match("Dark") then
        return "dark"
      else
        return "light"
      end
    end
    
    -- Get the current system theme
    local system_theme = get_macos_theme()
    local flavor = system_theme == "dark" and "mocha" or "latte"
    
    require("catppuccin").setup({
      flavour = flavor, -- Set based on system theme
      background = { -- :h background
        light = "latte",
        dark = "mocha",
      },
      transparent_background = true, -- disables setting the background color.
      show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
      term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
      dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
      },
      no_italic = false, -- Force no italic
      no_bold = false, -- Force no bold
      no_underline = false, -- Force no underline
      styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      color_overrides = {},
      custom_highlights = {
        LineNr = { fg = "#FFD700" }, -- Bright yellow color for line numbers
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
      },
    })

    vim.cmd([[colorscheme catppuccin]])
    
    -- Set up autocmd to check for system theme changes
    -- This will check when Neovim gains focus
    vim.api.nvim_create_autocmd("FocusGained", {
      callback = function()
        local new_theme = get_macos_theme()
        if new_theme ~= system_theme then
          system_theme = new_theme
          local new_flavor = new_theme == "dark" and "mocha" or "latte"
          require("catppuccin").setup({
            flavour = new_flavor,
            background = {
              light = "latte",
              dark = "mocha",
            },
            transparent_background = true,
            show_end_of_buffer = false,
            term_colors = false,
            dim_inactive = {
              enabled = false,
              shade = "dark",
              percentage = 0.15,
            },
            no_italic = false,
            no_bold = false,
            no_underline = false,
            styles = {
              comments = { "italic" },
              conditionals = { "italic" },
              loops = {},
              functions = {},
              keywords = {},
              strings = {},
              variables = {},
              numbers = {},
              booleans = {},
              properties = {},
              types = {},
              operators = {},
            },
            color_overrides = {},
            custom_highlights = {
              LineNr = { fg = "#FFD700" },
            },
            integrations = {
              cmp = true,
              gitsigns = true,
              nvimtree = true,
              treesitter = true,
              notify = false,
              mini = {
                enabled = true,
                indentscope_color = "",
              },
            },
          })
          vim.cmd("colorscheme catppuccin")
        end
      end,
    })
  end,
}


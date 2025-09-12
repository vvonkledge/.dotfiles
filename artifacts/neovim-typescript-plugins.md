# Neovim TypeScript Development Environment - Plugin Configuration Guide

## Purpose
This document provides a comprehensive guide for configuring Neovim as a powerful TypeScript development environment. It lists essential plugins, their purposes, and recommended configurations for optimal TypeScript/JavaScript development.

## Core Language Server Protocol (LSP) Setup

### typescript-tools.nvim
- **Purpose**: Direct TypeScript language server integration without proxy layer
- **Priority**: REQUIRED - Primary TypeScript LSP solution
- **Advantages**: Better performance than typescript-language-server, native TypeScript protocol support, jsx_close_tag support
- **Configuration**: Replace standard tsserver setup with this plugin for superior TypeScript support

### nvim-lspconfig
- **Purpose**: Quickstart configurations for Neovim's built-in LSP client
- **Priority**: REQUIRED - Foundation for all LSP functionality
- **Configuration**: Essential for configuring language servers, provides pre-configured settings for TypeScript

### mason.nvim + mason-lspconfig.nvim + mason-tool-installer.nvim
- **Purpose**: Automated installation and management of LSP servers, linters, formatters, and DAP adapters
- **Priority**: REQUIRED - Simplifies toolchain management
- **Configuration**: Install typescript-language-server, eslint-lsp, prettier, prettierd, and other TypeScript tools

## Autocompletion System

### nvim-cmp
- **Purpose**: Fast, extensible completion engine written in Lua
- **Priority**: REQUIRED - Core completion functionality
- **Required Sources**:
  - `cmp-nvim-lsp`: LSP completion source
  - `cmp-buffer`: Buffer words completion
  - `cmp-path`: Filesystem path completion
  - `cmp-cmdline`: Command-line completion
  - `cmp_luasnip`: Snippet completion integration

### LuaSnip
- **Purpose**: Snippet engine with VSCode snippet format support
- **Priority**: REQUIRED - Essential for productive coding
- **Configuration**: Load friendly-snippets for TypeScript/React snippets

### lspkind.nvim
- **Purpose**: VSCode-like pictograms in completion menu
- **Priority**: RECOMMENDED - Improves completion UI readability
- **Configuration**: Enable icons for different completion item types

## Syntax and Code Understanding

### nvim-treesitter
- **Purpose**: Incremental parsing for better syntax highlighting and code analysis
- **Priority**: REQUIRED - Foundation for modern Neovim features
- **Required Parsers**: typescript, tsx, javascript, jsx, json, html, css
- **Modules**: Enable highlight, indent, incremental_selection, textobjects

### nvim-treesitter-textobjects
- **Purpose**: Semantic text objects for TypeScript code navigation
- **Priority**: RECOMMENDED - Enhances code navigation
- **Configuration**: Setup function, class, parameter, and comment text objects

### nvim-ts-autotag
- **Purpose**: Automatic HTML/JSX/TSX tag closing and renaming
- **Priority**: REQUIRED for React development
- **Configuration**: Enable for typescriptreact and javascriptreact filetypes

### nvim-treesitter-context
- **Purpose**: Shows code context in floating window at top of buffer
- **Priority**: OPTIONAL - Useful for large files
- **Configuration**: Limit to TypeScript-relevant contexts (function, class, method)

## Code Formatting and Linting

### conform.nvim
- **Purpose**: Modern, async code formatter
- **Priority**: REQUIRED - Replaces deprecated null-ls formatting
- **Formatters**: prettier, prettierd for TypeScript/JavaScript
- **Configuration**: Format on save, check for local prettier in node_modules first

### nvim-lint
- **Purpose**: Asynchronous linting framework
- **Priority**: REQUIRED - Replaces deprecated null-ls linting
- **Linters**: eslint_d for TypeScript/JavaScript
- **Configuration**: Lint on BufWritePost, BufReadPost, InsertLeave

### ESLint LSP
- **Purpose**: Native ESLint integration through LSP
- **Priority**: RECOMMENDED - Better than eslint_d for most use cases
- **Configuration**: Enable autofix on save, configure through nvim-lspconfig

## Debugging

### nvim-dap
- **Purpose**: Debug Adapter Protocol client implementation
- **Priority**: REQUIRED for debugging
- **Configuration**: Core debugging infrastructure

### nvim-dap-vscode-js
- **Purpose**: Microsoft's vscode-js-debug adapter for nvim-dap
- **Priority**: REQUIRED for TypeScript debugging
- **Configuration**: Setup for node, chrome, pwa-node, pwa-chrome

### nvim-dap-ui
- **Purpose**: Full-featured UI for nvim-dap
- **Priority**: REQUIRED for debugging
- **Configuration**: Setup layouts for variables, breakpoints, stack trace, console

### nvim-dap-virtual-text
- **Purpose**: Display variable values as virtual text during debugging
- **Priority**: RECOMMENDED - Improves debugging experience
- **Configuration**: Enable for TypeScript files

## Testing Integration

### neotest
- **Purpose**: Extensible testing framework
- **Priority**: RECOMMENDED for test-driven development
- **Configuration**: Core testing infrastructure

### neotest-jest
- **Purpose**: Jest adapter for neotest
- **Priority**: REQUIRED if using Jest
- **Configuration**: Configure jest command and test file patterns

### neotest-vitest
- **Purpose**: Vitest adapter for neotest
- **Priority**: REQUIRED if using Vitest
- **Configuration**: Configure vitest command and test file patterns

## File Navigation and Search

### telescope.nvim
- **Purpose**: Highly extensible fuzzy finder
- **Priority**: REQUIRED - Essential for project navigation
- **Dependencies**: plenary.nvim, ripgrep, fd
- **Extensions**:
  - `telescope-fzf-native.nvim`: Native FZF sorter for performance
  - `telescope-live-grep-args.nvim`: Pass arguments to ripgrep
  - `telescope-node-modules.nvim`: Navigate node_modules

### nvim-tree.lua OR neo-tree.nvim
- **Purpose**: File explorer tree
- **Priority**: RECOMMENDED - Visual file navigation
- **Configuration**: Show git status, filter node_modules, integrate with project root

## Git Integration

### gitsigns.nvim
- **Purpose**: Git decorations and inline git blame
- **Priority**: REQUIRED - Essential git information
- **Features**: Show git diff in sign column, stage hunks, preview changes

### vim-fugitive
- **Purpose**: Comprehensive Git wrapper
- **Priority**: REQUIRED - Git operations within Neovim
- **Features**: Git blame, log, diff, merge conflict resolution

### diffview.nvim
- **Purpose**: Git diff viewer with merge tool
- **Priority**: RECOMMENDED - Better diff visualization
- **Configuration**: Setup for merge conflict resolution

## TypeScript-Specific Enhancements

### typescript.nvim (DEPRECATED - use typescript-tools.nvim instead)
- **Note**: This plugin is deprecated in favor of typescript-tools.nvim

### ts-error-translator.nvim
- **Purpose**: Translates cryptic TypeScript errors to plain English
- **Priority**: HIGHLY RECOMMENDED - Dramatically improves error readability
- **Configuration**: Auto-attach to tsserver, configure translation preferences

### tsc.nvim
- **Purpose**: Asynchronous project-wide type checking
- **Priority**: RECOMMENDED - Run tsc without leaving Neovim
- **Configuration**: Setup keybinding for type checking entire project

### workspace-diagnostics.nvim
- **Purpose**: Populate diagnostics for entire workspace
- **Priority**: RECOMMENDED - See all project errors
- **Configuration**: Trigger on LSP attach, limit to TypeScript files

### package-info.nvim
- **Purpose**: Display package.json dependency information
- **Priority**: OPTIONAL - Useful for dependency management
- **Features**: Show latest versions, update dependencies

### SchemaStore.nvim
- **Purpose**: JSON schemas for tsconfig.json and other config files
- **Priority**: RECOMMENDED - Better IntelliSense for config files
- **Configuration**: Integrate with jsonls LSP

## UI Enhancements

### lualine.nvim
- **Purpose**: Fast and customizable statusline
- **Priority**: REQUIRED - Essential status information
- **Configuration**: Show LSP status, git branch, diagnostics count

### bufferline.nvim
- **Purpose**: Enhanced buffer/tab line
- **Priority**: RECOMMENDED - Better buffer management
- **Configuration**: Show diagnostics, close button, buffer sorting

### noice.nvim
- **Purpose**: Replaces UI for messages, cmdline, and popupmenu
- **Priority**: OPTIONAL - Modern UI experience
- **Dependencies**: nui.nvim, nvim-notify

### which-key.nvim
- **Purpose**: Display available keybindings
- **Priority**: HIGHLY RECOMMENDED - Discoverability
- **Configuration**: Setup TypeScript-specific keybinding groups

### indent-blankline.nvim
- **Purpose**: Display indent guides
- **Priority**: RECOMMENDED - Code structure visualization
- **Configuration**: Configure for TypeScript indent levels

### todo-comments.nvim
- **Purpose**: Highlight and search TODO, FIXME, etc.
- **Priority**: OPTIONAL - Project task tracking
- **Configuration**: Setup TypeScript comment patterns

## Productivity Enhancements

### nvim-autopairs
- **Purpose**: Automatic bracket/quote pairing
- **Priority**: REQUIRED - Reduces typing
- **Configuration**: Integrate with nvim-cmp, setup for TypeScript

### nvim-ts-context-commentstring
- **Purpose**: Context-aware comment strings for JSX/TSX
- **Priority**: REQUIRED for React development
- **Configuration**: Setup for embedded languages in TypeScript

### Comment.nvim
- **Purpose**: Smart commenting with motions
- **Priority**: REQUIRED - Essential editing operation
- **Configuration**: Integrate with nvim-ts-context-commentstring

### nvim-surround
- **Purpose**: Add/change/delete surrounding delimiters
- **Priority**: RECOMMENDED - Powerful text manipulation
- **Configuration**: Default configuration works well

### leap.nvim OR flash.nvim
- **Purpose**: Fast cursor navigation
- **Priority**: OPTIONAL - Enhanced movement
- **Configuration**: Setup comfortable keybindings

## Project Management

### project.nvim
- **Purpose**: Automatic project root detection
- **Priority**: RECOMMENDED - Better project navigation
- **Configuration**: Detect based on package.json, tsconfig.json, .git

### persistence.nvim
- **Purpose**: Session management
- **Priority**: OPTIONAL - Restore working state
- **Configuration**: Auto-save sessions per project

## AI Assistance

### copilot.lua + copilot-cmp
- **Purpose**: GitHub Copilot integration
- **Priority**: OPTIONAL - AI code completion
- **Configuration**: Setup with nvim-cmp, configure suggestion behavior

### codeium.vim
- **Purpose**: Free AI code completion alternative
- **Priority**: OPTIONAL - Alternative to Copilot
- **Configuration**: Setup authentication and keybindings

## Performance Optimization

### lazy.nvim
- **Purpose**: Modern plugin manager with lazy loading
- **Priority**: REQUIRED - Startup time optimization
- **Configuration**: Lazy load plugins based on events, commands, filetypes

### impatient.nvim (DEPRECATED)
- **Note**: No longer needed with Neovim 0.9+ built-in loader

## Recommended Plugin Installation Order

1. **Foundation** (Install First):
   - lazy.nvim (plugin manager)
   - nvim-treesitter
   - nvim-lspconfig
   - mason.nvim

2. **Core Development** (Install Second):
   - typescript-tools.nvim
   - nvim-cmp and sources
   - conform.nvim
   - nvim-lint

3. **Enhanced Experience** (Install Third):
   - telescope.nvim
   - gitsigns.nvim
   - which-key.nvim
   - lualine.nvim

4. **Advanced Features** (Install as Needed):
   - nvim-dap ecosystem
   - neotest ecosystem
   - TypeScript-specific plugins

## Configuration Best Practices

### Performance Considerations
- ALWAYS use lazy loading where possible
- DEFER plugin loading using lazy.nvim events
- LIMIT treesitter parsers to needed languages
- DISABLE unused LSP features (semantic tokens if not needed)

### TypeScript-Specific Settings
- CONFIGURE tsserver to use project TypeScript version
- ENABLE organize imports on save
- SETUP import sorting preferences
- CONFIGURE JSX/TSX specific settings

### Keybinding Recommendations
- NAMESPACE TypeScript commands under `<leader>t`
- SETUP quick access to type definitions (`gd`, `gr`, `gi`)
- CONFIGURE refactoring shortcuts
- CREATE testing keybindings under `<leader>tt`

## Common Issues and Solutions

### Issue: Slow TypeScript LSP
- SOLUTION: Use typescript-tools.nvim instead of typescript-language-server
- SOLUTION: Increase LSP timeout settings
- SOLUTION: Exclude node_modules from file watchers

### Issue: Format on save conflicts
- SOLUTION: Choose either LSP formatting OR conform.nvim, not both
- SOLUTION: Configure format priority order
- SOLUTION: Disable editor.formatOnSave in VSCode settings.json

### Issue: Missing TypeScript imports
- SOLUTION: Configure auto-import preferences in tsserver
- SOLUTION: Use telescope or LSP code actions for import

### Issue: JSX/TSX indentation problems
- SOLUTION: Configure treesitter indent for typescriptreact
- SOLUTION: Adjust shiftwidth and expandtab for TSX files

## Minimal Configuration Example Structure

```
~/.config/nvim/
├── init.lua                 # Entry point
├── lua/
│   ├── config/
│   │   ├── lazy.lua        # Plugin manager setup
│   │   ├── options.lua     # Neovim options
│   │   ├── keymaps.lua     # Global keymaps
│   │   └── autocmds.lua    # Auto commands
│   └── plugins/
│       ├── lsp.lua         # LSP configuration
│       ├── completion.lua  # Completion setup
│       ├── treesitter.lua  # Treesitter config
│       ├── telescope.lua   # Telescope config
│       ├── formatting.lua  # Conform + nvim-lint
│       └── typescript.lua  # TypeScript-specific
```

## Update and Maintenance

### Regular Updates
- UPDATE plugins weekly using lazy.nvim
- CHECK mason.nvim for LSP/tool updates
- REVIEW TypeScript/ESLint configuration changes
- MONITOR plugin deprecations and migrations

### Performance Monitoring
- USE `:Lazy profile` to identify slow plugins
- MONITOR LSP performance with `:LspInfo`
- CHECK startup time with `nvim --startuptime`
- OPTIMIZE based on actual usage patterns

## Additional Resources

### Plugin Combinations for Specific Workflows

#### React/Next.js Development
- REQUIRED: nvim-ts-autotag, tailwindcss-colorizer-cmp.nvim
- RECOMMENDED: tailwind-sorter.nvim, headlines.nvim for MDX

#### Node.js Backend Development
- REQUIRED: rest.nvim or kulala.nvim for API testing
- RECOMMENDED: nvim-dap-vscode-js for debugging

#### Full-Stack TypeScript
- REQUIRED: All core plugins plus database client plugins
- RECOMMENDED: vim-dadbod for database access

## Notes for AI Agents

When implementing this configuration:
1. MUST install plugins in the specified order to avoid dependency issues
2. MUST configure TypeScript LSP before other language features
3. SHOULD use lazy loading to optimize startup time
4. MUST test each plugin group before proceeding to the next
5. SHOULD customize keybindings based on user preferences
6. MUST ensure Node.js and npm/yarn are installed for TypeScript tools
7. SHOULD document any deviations from recommended setup
8. MUST verify Mason-installed tools are in PATH
9. SHOULD consider system resources when enabling features
10. MUST maintain consistent configuration style throughout
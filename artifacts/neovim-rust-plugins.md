# Neovim Rust Development Environment - Plugin Configuration Guide

## Purpose
This document provides a comprehensive guide for configuring Neovim as a powerful Rust development environment. It details essential plugins, their purposes, and recommended configurations optimized for Rust development including systems programming, embedded development, and web services.

## Critical Migration Notice (2024-2025)
- **DEPRECATED**: rust-tools.nvim was archived in January 2024
- **REQUIRED**: Migrate to rustaceanvim as the official successor
- **IMPORTANT**: rustaceanvim requires rust-analyzer >= 2025-01-20
- **WARNING**: Do not use rust-tools.nvim for new configurations

## Core Language Server Protocol (LSP) Setup

### rustaceanvim
- **Purpose**: Complete Rust development experience with rust-analyzer integration
- **Priority**: REQUIRED - Primary Rust development solution
- **Installation**: Use version tag to avoid breaking changes: `{ 'mrcjkb/rustaceanvim', version = '^6', lazy = false }`
- **Features**:
  - Zero-configuration design (no setup function required)
  - Automatic rust-analyzer configuration
  - Grouped code actions support
  - Background cargo check/clippy execution
  - HIR/MIR buffer inspection
  - Integrated neotest adapter
  - Standalone files support
  - Rustc diagnostics integration
- **Configuration**: MUST NOT call setup() - works as filetype plugin
- **Conflicts**: MUST NOT use nvim-lspconfig.rust_analyzer alongside

### nvim-lspconfig (Alternative Setup)
- **Purpose**: Manual rust-analyzer configuration
- **Priority**: OPTIONAL - Only if not using rustaceanvim
- **Configuration**: Standard rust_analyzer setup
- **Note**: Less features than rustaceanvim but more control

### mason.nvim + mason-lspconfig.nvim
- **Purpose**: Automated installation of Rust toolchain components
- **Priority**: REQUIRED - Toolchain management
- **Tools to Install**:
  - `rust-analyzer`: Language server
  - `codelldb`: Debugger adapter
  - `taplo`: TOML language server for Cargo.toml

## Rust Toolchain Management

### System Requirements
- **rustup**: REQUIRED - Rust toolchain installer
- **rust-analyzer**: REQUIRED - Install via rustup or Mason
- **cargo**: REQUIRED - Rust package manager
- **rustfmt**: REQUIRED - `rustup component add rustfmt`
- **clippy**: REQUIRED - `rustup component add clippy`
- **lldb**: RECOMMENDED - System debugger

### Version Management
- **rust-analyzer Version**: Must be >= 2025-01-20 for rustaceanvim
- **Rust Edition**: Configure 2021 or 2024 edition support
- **Toolchain**: Support for stable, beta, and nightly
- **Cross-compilation**: Multiple target support

## Autocompletion System

### nvim-cmp
- **Purpose**: Fast completion engine
- **Priority**: REQUIRED - Core completion functionality
- **Required Sources**:
  - `cmp-nvim-lsp`: LSP completion source
  - `cmp-buffer`: Buffer words completion
  - `cmp-path`: Filesystem path completion
  - `cmp-cmdline`: Command-line completion
  - `cmp_luasnip`: Snippet completion

### LuaSnip
- **Purpose**: Snippet engine with Rust snippets
- **Priority**: REQUIRED - Productivity enhancement
- **Configuration**: Load Rust-specific snippets from friendly-snippets

### lspkind.nvim
- **Purpose**: Completion item icons
- **Priority**: RECOMMENDED - UI enhancement
- **Configuration**: Icons for traits, structs, enums, functions

## Cargo Integration

### crates.nvim
- **Purpose**: Cargo.toml dependency management
- **Priority**: HIGHLY RECOMMENDED - Dependency management
- **Features**:
  - Version autocompletion in Cargo.toml
  - Outdated dependency indicators
  - crates.io integration
  - Documentation links
  - Feature flag completion
- **Configuration**: Enable virtual text for version information

### cargo.nvim (Alternative)
- **Purpose**: Cargo command integration
- **Priority**: OPTIONAL - Additional cargo commands
- **Features**: Run cargo commands from Neovim

## Syntax and Code Understanding

### nvim-treesitter
- **Purpose**: Advanced syntax highlighting and code analysis
- **Priority**: REQUIRED - Modern syntax features
- **Required Parsers**: rust, toml, markdown, comment
- **Modules**: highlight, indent, incremental_selection, textobjects
- **Configuration**: Enable rust parser with maintained = true

### nvim-treesitter-textobjects
- **Purpose**: Semantic text objects for Rust
- **Priority**: RECOMMENDED - Enhanced navigation
- **Text Objects**:
  - Function: `@function.outer`, `@function.inner`
  - Struct/Enum: `@class.outer`, `@class.inner`
  - Block: `@block.outer`, `@block.inner`
  - Parameter: `@parameter.outer`, `@parameter.inner`

### nvim-treesitter-context
- **Purpose**: Show code context at top of buffer
- **Priority**: OPTIONAL - Navigation aid
- **Configuration**: Show function, impl block, struct context

## Code Formatting

### rustfmt Integration (via LSP)
- **Purpose**: Official Rust code formatter
- **Priority**: REQUIRED - Code consistency
- **Configuration Methods**:
  1. Through rust-analyzer (recommended)
  2. Through conform.nvim
  3. Through rust.vim plugin
- **Settings**: Configure via rustfmt.toml in project root

### conform.nvim (Optional)
- **Purpose**: Unified formatting interface
- **Priority**: OPTIONAL - If managing multiple formatters
- **Configuration**: Use rustfmt for rust files

## Linting and Analysis

### clippy Integration
- **Purpose**: Rust linter with additional checks
- **Priority**: REQUIRED - Code quality
- **Configuration**:
  ```lua
  ["rust-analyzer"] = {
    checkOnSave = {
      command = "clippy",
      extraArgs = { "--all-targets", "--all-features" }
    }
  }
  ```

### nvim-lint (Optional)
- **Purpose**: Additional linting framework
- **Priority**: OPTIONAL - Extended linting
- **Note**: Usually not needed as rust-analyzer handles linting

## Debugging

### nvim-dap
- **Purpose**: Debug Adapter Protocol implementation
- **Priority**: REQUIRED for debugging
- **Configuration**: Core debugging infrastructure

### CodeLLDB Adapter
- **Purpose**: LLVM-based debugger for Rust
- **Priority**: REQUIRED for debugging
- **Installation**: Via Mason or manual download
- **Features**:
  - Better Rust type support than GDB
  - Rust-specific pretty printing
  - Async/await debugging support

### nvim-dap-ui
- **Purpose**: Full debugging interface
- **Priority**: REQUIRED for debugging
- **Layout**: Variables, breakpoints, stack trace, console

### nvim-dap-virtual-text
- **Purpose**: Inline variable values during debugging
- **Priority**: RECOMMENDED - Debugging enhancement
- **Configuration**: Enable for Rust files

### telescope-dap.nvim
- **Purpose**: DAP integration with telescope
- **Priority**: OPTIONAL - Debugging enhancement
- **Features**: Browse breakpoints, configurations

## Testing Integration

### rustaceanvim Built-in Testing
- **Purpose**: Native test execution
- **Priority**: REQUIRED - Included in rustaceanvim
- **Commands**:
  - `:RustLsp testables`: Run tests
  - `:RustLsp testables!`: Rerun last test
- **Configuration**: Background or terminal execution

### neotest + rustaceanvim Adapter
- **Purpose**: Advanced testing framework
- **Priority**: RECOMMENDED - Enhanced testing
- **Configuration**:
  ```lua
  require('neotest').setup {
    adapters = {
      require('rustaceanvim.neotest')
    }
  }
  ```

### neotest-rust (Alternative)
- **Purpose**: Alternative neotest adapter using cargo-nextest
- **Priority**: OPTIONAL - Only if not using rustaceanvim's adapter
- **Warning**: Do not use with rustaceanvim's neotest adapter

## Rust-Specific Features

### Inlay Hints
- **Purpose**: Type and parameter hints
- **Priority**: HIGHLY RECOMMENDED - Code clarity
- **Native Support**: Neovim 0.10+ has built-in support
- **Enable**: `:lua vim.lsp.inlay_hint.enable(true)`
- **Configuration**: Through rust-analyzer settings

### Expand Macro Support
- **Purpose**: View macro expansions
- **Priority**: RECOMMENDED - Macro debugging
- **Command**: `:RustLsp expandMacro` (rustaceanvim)
- **Alternative**: `cargo expand` command

### HIR/MIR Inspection
- **Purpose**: View compiler intermediate representations
- **Priority**: OPTIONAL - Advanced debugging
- **Commands**: Available through rustaceanvim

### Structural Search and Replace
- **Purpose**: AST-aware code modifications
- **Priority**: OPTIONAL - Refactoring
- **Access**: Through rust-analyzer code actions

## Documentation Integration

### Hover Documentation
- **Purpose**: Inline documentation display
- **Priority**: REQUIRED - Built into LSP
- **Enhancement**: Links to docs.rs

### cargo-doc Integration
- **Purpose**: Generate and view local documentation
- **Priority**: RECOMMENDED - Offline docs
- **Command**: `:!cargo doc --open`

### External Documentation
- **Purpose**: Quick access to docs.rs
- **Priority**: OPTIONAL - Online reference
- **Command**: `:RustLsp openDocs` (rustaceanvim)

## File Navigation and Search

### telescope.nvim
- **Purpose**: Fuzzy finder for Rust projects
- **Priority**: REQUIRED - Project navigation
- **Extensions**:
  - `telescope-fzf-native.nvim`: Performance improvement
  - Custom pickers for Cargo commands

### nvim-tree.lua OR neo-tree.nvim
- **Purpose**: File explorer
- **Priority**: RECOMMENDED - Visual navigation
- **Configuration**: Hide target directory, show Cargo.toml prominently

## Git Integration

### gitsigns.nvim
- **Purpose**: Git status in sign column
- **Priority**: REQUIRED - Version control
- **Features**: Inline blame, hunk staging

### vim-fugitive
- **Purpose**: Git commands
- **Priority**: REQUIRED - Git operations
- **Features**: Blame, log, diff

### diffview.nvim
- **Purpose**: Enhanced diff viewing
- **Priority**: OPTIONAL - Code review
- **Features**: Side-by-side diffs, merge conflict resolution

## Workspace and Multi-Crate Support

### Workspace Features
- **Native Support**: rust-analyzer handles workspaces automatically
- **Navigation**: Cross-crate go-to-definition
- **Building**: Unified cargo commands
- **Dependencies**: Shared Cargo.lock

### Project Management
- **project.nvim**: Automatic project root detection
- **Detection Patterns**: Cargo.toml, rust-toolchain.toml, .git
- **Session Support**: Per-project sessions with persistence.nvim

## Embedded Rust Development

### Additional Requirements
- **probe-rs**: Hardware debugging
- **cargo-embed**: Flashing and debugging
- **Target Configuration**: Cross-compilation support

### Configuration
- **rust-analyzer Settings**: Configure target triple
- **Build Commands**: Custom cargo commands for embedded
- **Debugging**: OpenOCD or probe-rs integration

## Performance and Profiling

### cargo-flamegraph Integration
- **Purpose**: Performance profiling visualization
- **Priority**: OPTIONAL - Performance analysis
- **Usage**: Run through terminal or async job

### criterion.rs Support
- **Purpose**: Benchmarking framework
- **Priority**: OPTIONAL - Performance testing
- **Integration**: Run benchmarks through cargo

## UI Enhancements

### lualine.nvim
- **Purpose**: Status line with Rust information
- **Priority**: REQUIRED - Status display
- **Rust Components**: Show cargo version, target, profile

### bufferline.nvim
- **Purpose**: Enhanced buffer display
- **Priority**: RECOMMENDED - Buffer management
- **Features**: Diagnostic indicators, grouping by crate

### which-key.nvim
- **Purpose**: Keybinding discovery
- **Priority**: HIGHLY RECOMMENDED - Discoverability
- **Rust Mappings**: Group under `<leader>r` for Rust commands

### indent-blankline.nvim
- **Purpose**: Indentation guides
- **Priority**: RECOMMENDED - Code structure
- **Configuration**: Rust-appropriate indent levels

### todo-comments.nvim
- **Purpose**: Highlight TODO, FIXME, etc.
- **Priority**: OPTIONAL - Task tracking
- **Rust Patterns**: Support for `// TODO:` and `//! TODO:`

## Productivity Enhancements

### nvim-autopairs
- **Purpose**: Automatic bracket pairing
- **Priority**: REQUIRED - Typing efficiency
- **Rust Support**: Angle brackets for generics, lifetime syntax

### Comment.nvim
- **Purpose**: Smart commenting
- **Priority**: REQUIRED - Code documentation
- **Rust Support**: `//` and `/* */` comments, doc comments `///` and `//!`

### nvim-surround
- **Purpose**: Surround text objects
- **Priority**: RECOMMENDED - Text manipulation
- **Rust Uses**: String literals, macro invocations

### leap.nvim OR flash.nvim
- **Purpose**: Fast navigation
- **Priority**: OPTIONAL - Movement enhancement
- **Configuration**: Quick jumps to Rust keywords

## AI Assistance

### copilot.lua + copilot-cmp
- **Purpose**: GitHub Copilot integration
- **Priority**: OPTIONAL - AI completion
- **Rust Support**: Trained on extensive Rust code

### codeium.vim
- **Purpose**: Free AI completion
- **Priority**: OPTIONAL - Copilot alternative
- **Rust Support**: Good Rust language support

## Performance Optimization

### lazy.nvim
- **Purpose**: Plugin manager with lazy loading
- **Priority**: REQUIRED - Startup optimization
- **Rust Optimizations**: Load Rust plugins on Rust filetypes only

### Rust-Specific Optimizations
- **Limit rust-analyzer Scope**: Configure workspace members
- **Disable Proc-Macro**: If not using procedural macros
- **Cargo Check Debouncing**: Reduce check frequency
- **Target Directory**: Use separate target for rust-analyzer

## Recommended Plugin Installation Order

1. **Foundation** (Install First):
   - lazy.nvim (plugin manager)
   - nvim-treesitter (with rust parser)
   - mason.nvim (tool management)

2. **Core Rust Development** (Install Second):
   - rustaceanvim (complete Rust IDE features)
   - nvim-cmp and sources (completion)
   - crates.nvim (dependency management)

3. **Enhanced Experience** (Install Third):
   - telescope.nvim (navigation)
   - gitsigns.nvim (git integration)
   - which-key.nvim (keybindings)
   - lualine.nvim (status line)

4. **Advanced Features** (Install as Needed):
   - nvim-dap + codelldb (debugging)
   - neotest integration (testing)
   - Embedded development tools

## Configuration Best Practices

### Performance Considerations
- ALWAYS lazy load plugins by filetype when possible
- LIMIT rust-analyzer to workspace members only
- CONFIGURE cargo check debouncing (save_delay)
- USE separate target directory for rust-analyzer
- DISABLE unused rust-analyzer features

### Rust-Specific Settings
- CONFIGURE rust edition (2021/2024)
- ENABLE all targets for clippy checks
- SETUP rustfmt.toml for project formatting
- CONFIGURE inlay hints preferences
- ENABLE proc-macro support if needed

### Keybinding Recommendations
- NAMESPACE Rust commands under `<leader>r`
- SETUP quick access to cargo commands
- CONFIGURE test running shortcuts
- CREATE debugging keybindings
- MAP code actions for quick fixes

## Common Issues and Solutions

### Issue: rust-analyzer High Memory Usage
- SOLUTION: Limit workspace members in rust-analyzer config
- SOLUTION: Disable proc-macro if not needed
- SOLUTION: Increase server timeout
- SOLUTION: Use excludeDirs for large directories

### Issue: Slow rust-analyzer Startup
- SOLUTION: Enable rust-analyzer.cargo.autoreload
- SOLUTION: Cache cargo metadata
- SOLUTION: Limit features in checkOnSave

### Issue: Proc-Macro Errors
- SOLUTION: Ensure proc-macro server versions match
- SOLUTION: Reinstall rust-analyzer via Mason
- SOLUTION: Check RUST_SRC_PATH environment variable

### Issue: Debugging Not Working
- SOLUTION: Install CodeLLDB via Mason
- SOLUTION: Ensure lldb is installed on system
- SOLUTION: Check debug build configuration

### Issue: Inlay Hints Not Showing
- SOLUTION: Enable in Neovim 0.10+: `vim.lsp.inlay_hint.enable(true)`
- SOLUTION: Configure rust-analyzer inlay hint settings
- SOLUTION: Check LSP client capabilities

## Minimal Configuration Example Structure

```
~/.config/nvim/
├── init.lua                    # Entry point
├── lua/
│   ├── config/
│   │   ├── lazy.lua           # Plugin manager setup
│   │   ├── options.lua        # Neovim options
│   │   ├── keymaps.lua        # Global keymaps
│   │   └── autocmds.lua       # Auto commands
│   └── plugins/
│       ├── rustacean.lua      # Rustaceanvim config
│       ├── completion.lua     # nvim-cmp setup
│       ├── treesitter.lua     # Treesitter config
│       ├── telescope.lua      # Telescope config
│       ├── debugging.lua      # DAP configuration
│       └── crates.lua         # Crates.nvim config
```

## Update and Maintenance

### Regular Updates
- UPDATE rustaceanvim following version tags
- MONITOR rust-analyzer releases monthly
- CHECK Mason for tool updates weekly
- REVIEW Rust edition changes
- UPDATE cargo dependencies regularly

### Performance Monitoring
- USE `:RustAnalyzer perf` for performance metrics
- MONITOR memory usage with `:lua vim.lsp.status()`
- CHECK startup time impact
- PROFILE slow operations

### Toolchain Maintenance
- KEEP rust-analyzer synchronized with rustc version
- UPDATE clippy for new lints
- MAINTAIN rustfmt.toml consistency
- SYNCHRONIZE with team configuration

## Additional Resources

### Workflow-Specific Configurations

#### Web Development (Actix/Rocket/Axum)
- REQUIRED: SQL/database client plugins
- RECOMMENDED: REST client plugin (rest.nvim)
- OPTIONAL: HTML/CSS/JS support

#### Embedded Development
- REQUIRED: probe-rs tools
- RECOMMENDED: Serial terminal integration
- OPTIONAL: Assembly syntax highlighting

#### Systems Programming
- REQUIRED: Enhanced debugging setup
- RECOMMENDED: Profiling tool integration
- OPTIONAL: Valgrind integration

#### WebAssembly Development
- REQUIRED: wasm-pack integration
- RECOMMENDED: WASM debugger setup
- OPTIONAL: JavaScript/TypeScript plugins

## Notes for AI Agents

When implementing this configuration:

1. MUST install rustaceanvim instead of deprecated rust-tools.nvim
2. MUST NOT call setup() function for rustaceanvim - it's a filetype plugin
3. MUST ensure rust-analyzer version >= 2025-01-20
4. MUST install Rust toolchain components (rustfmt, clippy) via rustup
5. SHOULD configure cargo check to run on save
6. MUST NOT mix rustaceanvim with nvim-lspconfig.rust_analyzer
7. SHOULD lazy load plugins for Rust filetypes only
8. MUST verify CodeLLDB installation for debugging support
9. SHOULD configure workspace-specific settings for multi-crate projects
10. MUST test configuration with both simple and workspace projects
11. SHOULD document any deviations from standard setup
12. MUST handle both stable and nightly toolchains appropriately
13. SHOULD optimize rust-analyzer for project size
14. MUST maintain compatibility with Cargo.toml and rust-toolchain.toml
15. SHOULD consider embedded/WASM targets if specified by user

## Critical Warnings

- NEVER use rust-tools.nvim in new configurations (archived January 2024)
- NEVER call rustaceanvim.setup() - it will break the plugin
- NEVER configure rust_analyzer through nvim-lspconfig if using rustaceanvim
- ALWAYS verify rust-analyzer version compatibility
- ALWAYS install system dependencies (lldb) for debugging
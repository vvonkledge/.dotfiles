# Ghostty Terminal Emulator: Comprehensive Technical Documentation for AI Agents

## Document Metadata
- **Purpose**: Technical reference for AI agents to understand and configure Ghostty terminal emulator
- **Platform Focus**: macOS primary, Linux secondary
- **Last Updated**: 2025-09-11
- **Version Coverage**: Ghostty 1.0+

## Executive Summary

Ghostty is a next-generation terminal emulator created by Mitchell Hashimoto (co-founder of HashiCorp). It is built with Zig, uses platform-native GUI frameworks, and provides GPU-accelerated rendering. The architecture uniquely separates core terminal emulation (libghostty) from platform-specific GUI implementations, enabling native experiences while sharing 90% of code.

## Core Architecture

### Technology Stack
```
Core Library (libghostty):
- Language: Zig
- API: C-ABI compatible
- Components: Terminal emulation, font handling, GPU rendering

Platform GUI:
- macOS: Swift (AppKit + SwiftUI)
- Linux: Zig (GTK4 C API)
- Windows: Planned (tracking in issue #2563)
```

### Architectural Layers
1. **libghostty** - Cross-platform terminal emulation core
2. **Platform GUI Layer** - Native UI implementation
3. **Renderer** - Metal (macOS) or OpenGL 3.3+ (Linux)
4. **IO Thread** - Dedicated thread for PTY and escape sequence handling
5. **Surface Management** - Windows, tabs, and splits orchestration

### Key Design Decisions
- **Separation of Concerns**: Core logic separate from GUI
- **Native-First**: Platform conventions over universal consistency
- **Performance Priority**: GPU acceleration by default
- **Standards Compliance**: xterm compatibility as baseline
- **Zero Configuration**: Works out-of-box with sensible defaults

## Installation and Setup

### macOS Installation
```bash
# Homebrew (recommended)
brew install ghostty

# Manual installation
# Download .dmg from ghostty.org
# Move Ghostty.app to /Applications
```

### Configuration File Location
```bash
# Primary location
~/.config/ghostty/config

# macOS app bundle resources (for bundled configs)
/Applications/Ghostty.app/Contents/Resources/
```

## Configuration System

### Syntax Specification
```ini
# Basic syntax: key = value
# Comments start with #
# Whitespace around = is ignored
# Values can be quoted or unquoted

font-family = JetBrains Mono
font-size = 14
theme = catppuccin-mocha
```

### Configuration Loading Order
1. Built-in defaults
2. `~/.config/ghostty/config`
3. Files specified via `config-file` keys
4. Command-line arguments

### Key Configuration Categories

#### Display Configuration
```ini
# Window dimensions (in character cells)
window-height = 30
window-width = 110

# macOS-specific titlebar styles
macos-titlebar-style = transparent  # native|hidden|transparent|tabs

# Transparency and effects
background-opacity = 0.95
background-blur = true

# Color space (macOS)
window-colorspace = display-p3  # srgb|display-p3
```

#### Font Configuration
```ini
# Primary font
font-family = JetBrains Mono
font-size = 14

# Font variations
font-family-bold = JetBrains Mono Bold
font-family-italic = JetBrains Mono Italic
font-family-bold-italic = JetBrains Mono Bold Italic

# macOS font thickening
font-thicken = true
font-thicken-strength = 50  # 0-255

# Typography features
font-feature = -liga  # Disable ligatures
font-feature = +ss01  # Enable stylistic set 1
```

#### Theme Configuration
```ini
# Single theme
theme = tokyonight

# Adaptive theming (light/dark mode)
theme = dark:tokyonight-night,light:tokyonight-day

# Override specific colors
background = 1a1b26
foreground = c0caf5
palette = 0=#15161e
palette = 1=#f7768e
```

#### Keybinding Configuration
```ini
# Basic keybinding syntax
keybind = trigger=action[:parameter]

# Examples
keybind = cmd+n=new_window
keybind = cmd+t=new_tab
keybind = cmd+w=close_surface

# Multi-key sequences
keybind = cmd+s>r=reload_config
keybind = cmd+s>n=new_window

# Global keybindings (requires accessibility permissions)
keybind = global:cmd+grave_accent=toggle_quick_terminal
```

## macOS-Specific Features

### Quick Terminal
```ini
# Enable dropdown terminal overlay
keybind = global:cmd+grave_accent=toggle_quick_terminal

# Configuration
quick-terminal-screen = main  # main|cursor|all
quick-terminal-position = top  # top|bottom|left|right|center
quick-terminal-animation = true
quick-terminal-autohide = true
```

### Platform Integration
- **Quick Look**: Three-finger tap or Force Touch for definitions
- **Secure Keyboard Entry**: Automatic password prompt detection
- **Native Tabs**: True macOS tabs, not custom implementation
- **Dock Integration**: Badge notifications and progress bars
- **Desktop Notifications**: Native notification center support

### macOS System Requirements
- **Minimum OS**: macOS 13.0 (Ventura)
- **Recommended**: macOS 14.0+ for full feature support
- **Architecture**: Universal binary (Intel + Apple Silicon)

## Advanced Features

### Custom Shaders
```ini
# Load GLSL shaders (requires OpenGL 4.2 on Linux)
custom-shader = ~/.config/ghostty/shaders/crt.glsl
custom-shader = ~/.config/ghostty/shaders/bloom.glsl
custom-shader-animation = true

# Shader API follows Shadertoy conventions
# iChannel0 = terminal screen texture
```

### Shell Integration
```ini
# Automatic shell detection and integration
shell-integration = detect  # auto|detect|bash|zsh|fish|none

# Feature toggles
shell-integration-features = cursor,sudo,title

# Features enable:
# - jump_to_prompt navigation
# - Working directory inheritance
# - Command output selection
# - Process-aware close confirmation
```

### Image Protocol Support
```ini
# Kitty graphics protocol configuration
image-storage-limit = 335544320  # 320MB default
# Set to 0 to disable image support
```

### Split Management
```ini
# Visual configuration for splits
unfocused-split-opacity = 0.7
unfocused-split-fill = #000000
split-divider-color = #444444

# Behavior
focus-follows-mouse = true
```

### Clipboard Configuration
```ini
# Security controls
clipboard-read = ask     # true|false|ask
clipboard-write = true   # true|false|ask

# Behavior
clipboard-trim-trailing-spaces = true
clipboard-paste-protection = true
copy-on-select = clipboard
```

## Performance Characteristics

### Benchmark Results (vs Competition)
```
Plain Text Processing:
- 4x faster than iTerm2/Kitty
- 2x faster than Terminal.app
- Comparable to Alacritty

DOOM Fire Benchmark (FPS):
- Ghostty: 135-515 fps (platform dependent)
- Kitty: 273 fps
- Alacritty: 164 fps
- WezTerm: 64-430 fps

Memory Usage:
- Baseline: 170-178MB
- Scales efficiently with multiple panes
- Style ID optimization for typical use cases
```

### Performance Features
- **Dedicated IO Thread**: Minimal jitter under load
- **GPU Decoupling**: Separate rendering from IO
- **Frame Rate**: Consistent 60fps under heavy load
- **Latency**: 2ms during 10k-line scroll tests

## Common Configuration Patterns

### Minimalist Configuration
```ini
theme = catppuccin-mocha
font-family = JetBrains Mono
font-size = 14
window-save-state = always
```

### Power User Configuration
```ini
# Theme and appearance
theme = dark:tokyonight-night,light:tokyonight-day
background-opacity = 0.95
font-thicken = true

# Advanced keybindings
keybind = cmd+s>r=reload_config
keybind = cmd+s>n=new_window
keybind = cmd+s>c=new_tab
keybind = global:cmd+grave_accent=toggle_quick_terminal

# Shell integration
shell-integration = detect
shell-integration-features = cursor,sudo,title

# Performance
image-storage-limit = 0  # Disable images for performance
```

### Development Environment
```ini
# Font optimized for coding
font-family = MonoLisa Variable
font-size = 13
font-feature = -liga  # Disable ligatures

# Window management
window-height = 40
window-width = 140
macos-titlebar-style = tabs

# Split configuration
unfocused-split-opacity = 0.8
focus-follows-mouse = true

# Clipboard
copy-on-select = clipboard
clipboard-trim-trailing-spaces = true
```

## Debugging and Troubleshooting

### Diagnostic Commands
```bash
# Show current configuration
ghostty +show-config

# Show default configuration with documentation
ghostty +show-config --default --docs

# List all available themes
ghostty +list-themes

# List all keybindings
ghostty +list-keybinds

# Validate configuration
ghostty +validate-config

# View crash reports
ghostty +crash-report
```

### Common Issues and Solutions

#### Quick Terminal Not Working
```ini
# Ensure global keybinding is set
keybind = global:cmd+grave_accent=toggle_quick_terminal

# Grant accessibility permissions:
# System Settings → Privacy & Security → Accessibility → Ghostty
```

#### Font Rendering Issues
```ini
# macOS font fixes
font-thicken = true
font-thicken-strength = 75
adjust-cell-height = 10%
```

#### Performance Problems
```ini
# Disable resource-intensive features
custom-shader-animation = false
image-storage-limit = 0
background-blur = false
```

## API Integration for AI Agents

### Configuration Generation
When generating configurations:
1. Use simple key=value syntax
2. Validate theme names against built-in list
3. Ensure font-family is available on system
4. Platform-specific keys should match target OS

### File Operations
```bash
# Configuration file paths
~/.config/ghostty/config          # Main config
~/.config/ghostty/themes/         # Custom themes
~/.config/ghostty/shaders/        # Custom shaders

# Commands for AI execution
ghostty --font-size=16            # Override single setting
ghostty +list-themes | grep dark  # Search themes
ghostty +show-config | grep font  # Check current fonts
```

### Keybinding Generation Rules
1. macOS uses `cmd`, Linux uses `ctrl`
2. Global keybindings require `global:` prefix
3. Sequences use `>` separator
4. Actions may have parameters after `:`

### Platform Detection
```bash
# Detect platform for configuration
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS-specific config
    echo "macos-titlebar-style = transparent"
else
    # Linux-specific config
    echo "gtk-tabs-location = top"
fi
```

## Future Roadmap (2025)

### libghostty Standalone Release
- Stable C API for third-party integration
- Enable ecosystem of terminal-based applications
- Support for web-based terminals
- New terminal multiplexer possibilities

### Planned Features
- Windows support (tracking #2563)
- Background image support (proposed #3645)
- Enhanced custom link patterns
- Extended regex configuration
- Additional graphics protocols

## Best Practices for AI Configuration

### When Configuring Ghostty:
1. **Start Minimal**: Begin with theme and font only
2. **Test Incrementally**: Add features one at a time
3. **Platform Awareness**: Use OS-specific features appropriately
4. **Performance First**: Disable unused features
5. **Documentation**: Comment complex configurations

### When Assisting Users:
1. **Verify Platform**: Check macOS vs Linux
2. **Check Version**: Features vary by version
3. **Validate Syntax**: Use exact key names
4. **Test Commands**: Verify with diagnostic tools
5. **Fallback Options**: Provide alternatives for issues

## Quick Reference

### Essential Files
```
~/.config/ghostty/config       # Main configuration
/tmp/ghostty-$USER/            # Runtime files
~/Library/Logs/Ghostty/        # macOS logs
```

### Essential Commands
```bash
ghostty                        # Launch terminal
ghostty +list-themes          # List themes
ghostty +show-config          # Show config
ghostty --theme=dracula       # Override theme
cmd+,                         # Open settings (macOS)
```

### Essential Keybindings (macOS)
```
cmd+n          # New window
cmd+t          # New tab
cmd+w          # Close current
cmd+,          # Reload config
cmd+plus       # Increase font
cmd+minus      # Decrease font
```

## Technical Notes for AI Agents

### Memory Considerations
- Configuration is loaded once at startup
- Runtime reload via keybinding or action
- Each surface maintains independent state
- Shared process model reduces memory overhead

### File Format Constraints
- No JSON/YAML/TOML support
- Simple key=value only
- No nested structures
- Comments on separate lines only
- UTF-8 encoding required

### Integration Points
- C-ABI compatible libghostty
- OSC escape sequences for control
- Standard Unix PTY interface
- Platform-native clipboard APIs
- XDG desktop standards (Linux)

This documentation provides comprehensive technical details for AI agents to understand, configure, and troubleshoot Ghostty terminal emulator with focus on macOS platform specifics and practical configuration patterns.
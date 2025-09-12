# tmux: Comprehensive Guide for AI Agents

## Document Purpose
This document provides detailed tmux (terminal multiplexer) knowledge optimized for AI agent consumption. All commands, configurations, and patterns are structured for precise implementation on macOS systems.

## System Requirements
- **Platform**: macOS (Darwin)
- **Installation Method**: Homebrew preferred
- **Configuration File Location**: `~/.tmux.conf`
- **Current Version Check**: `tmux -V`

## Core Architecture Understanding

### Client-Server Model
tmux operates on a CLIENT-SERVER architecture where:
- **Server**: Background daemon managing all sessions, windows, and panes
- **Client**: Terminal interface connecting to the server via socket
- **Persistence**: Server maintains state even when client disconnects
- **Auto-management**: Server starts automatically on first tmux command, stops when last session closes

### Hierarchy Structure
```
Server (1)
  └── Sessions (multiple)
        └── Windows (multiple per session)
              └── Panes (multiple per window)
```

## Installation on macOS

### Primary Method (Homebrew)
```bash
# Install tmux
brew install tmux

# Verify installation
tmux -V

# Install UTF-8 support (REQUIRED for macOS)
brew install utf8proc
```

### macOS-Specific Considerations
- **UTF-8 Issue**: macOS has poor builtin UTF-8 support. ALWAYS install utf8proc
- **Clipboard Integration**: Requires special configuration with pbcopy/pbpaste
- **iTerm2 Integration**: Supports native mode with `tmux -CC`

## Essential Commands Reference

### Session Management
```bash
# Create new session
tmux new -s session_name

# List all sessions
tmux ls

# Attach to session
tmux attach -t session_name
tmux a -t session_name  # shortened

# Detach from session (inside tmux)
Ctrl+b d

# Kill session
tmux kill-session -t session_name

# Rename session (inside tmux)
Ctrl+b $
```

### Window Management (Inside tmux)
```
Ctrl+b c        # Create new window
Ctrl+b n        # Next window
Ctrl+b p        # Previous window
Ctrl+b 0-9      # Switch to window by number
Ctrl+b w        # List windows
Ctrl+b ,        # Rename current window
Ctrl+b &        # Kill current window
```

### Pane Management (Inside tmux)
```
Ctrl+b %        # Split vertically
Ctrl+b "        # Split horizontally
Ctrl+b o        # Switch to next pane
Ctrl+b ;        # Toggle last active pane
Ctrl+b x        # Kill current pane
Ctrl+b z        # Toggle pane zoom
Ctrl+b {        # Move pane left
Ctrl+b }        # Move pane right
Ctrl+b arrow    # Navigate panes
Ctrl+b Ctrl+arrow  # Resize pane (hold Ctrl)
```

## Configuration File Structure

### Location and Loading
```bash
# Primary configuration file
~/.tmux.conf

# Reload configuration without restart
tmux source-file ~/.tmux.conf

# Or bind reload to key
# Add to ~/.tmux.conf:
bind r source-file ~/.tmux.conf \; display "Config reloaded!"
```

### Essential Configuration Template
```bash
# ~/.tmux.conf

# Change prefix from Ctrl+b to Ctrl+a
unbind C-b
set -g prefix C-a
bind C-a send-prefix

# Enable mouse mode
set -g mouse on

# Set base index to 1 (not 0)
set -g base-index 1
setw -g pane-base-index 1

# Improve colors
set -g default-terminal "screen-256color"

# Increase scrollback buffer
set -g history-limit 10000

# Faster key repetition
set -s escape-time 0

# Activity monitoring
setw -g monitor-activity on
set -g visual-activity on

# Status bar customization
set -g status-bg black
set -g status-fg white
set -g status-left-length 40
set -g status-left '#[fg=green]#S #[fg=yellow]#I:#P'
set -g status-right '#[fg=yellow]%Y-%m-%d %H:%M'
```

## macOS Clipboard Integration

### Basic pbcopy/pbpaste Setup
```bash
# Add to ~/.tmux.conf for tmux 2.4+

# Copy mode vi bindings
setw -g mode-keys vi

# Setup 'v' to begin selection in copy mode
bind-key -T copy-mode-vi v send-keys -X begin-selection

# Use pbcopy for copying
bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "pbcopy"

# Mouse selection copy
bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "pbcopy"
```

### Advanced: reattach-to-user-namespace
```bash
# Install if clipboard doesn't work
brew install reattach-to-user-namespace

# Update ~/.tmux.conf
set-option -g default-command "reattach-to-user-namespace -l ${SHELL}"
bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "reattach-to-user-namespace pbcopy"
```

## Plugin Management

### Installing TPM (Tmux Plugin Manager)
```bash
# Clone TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Add to ~/.tmux.conf
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'

# Initialize TPM (keep at bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'

# Install plugins (inside tmux)
Ctrl+b I
```

### Essential Plugins Configuration
```bash
# Add to ~/.tmux.conf

# Core plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'

# Session persistence
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'

# Clipboard integration
set -g @plugin 'tmux-plugins/tmux-yank'

# Configure continuum
set -g @continuum-restore 'on'
set -g @continuum-save-interval '15'

# Configure resurrect
set -g @resurrect-capture-pane-contents 'on'
set -g @resurrect-strategy-vim 'session'
```

## Advanced Scripting

### Sending Commands to Panes
```bash
# Send command to specific pane
tmux send-keys -t session:window.pane "command" C-m

# Example: Send to session 0, window 1, pane 0
tmux send-keys -t 0:1.0 "ls -la" C-m

# Send to current pane
tmux send-keys "echo 'Hello'" Enter
```

### Creating Complex Layouts via Script
```bash
#!/bin/bash
# tmux-dev-setup.sh

# Create new session
tmux new-session -d -s dev -n editor

# Split window into panes
tmux split-window -h -t dev:editor
tmux split-window -v -t dev:editor.1

# Send commands to each pane
tmux send-keys -t dev:editor.0 "vim" C-m
tmux send-keys -t dev:editor.1 "npm run dev" C-m
tmux send-keys -t dev:editor.2 "git status" C-m

# Attach to session
tmux attach-session -t dev
```

### Synchronize Panes for Parallel Execution
```bash
# Enable synchronization (type in all panes)
tmux setw synchronize-panes on

# Disable synchronization
tmux setw synchronize-panes off

# Bind to key
# Add to ~/.tmux.conf:
bind S setw synchronize-panes
```

## iTerm2 Integration (macOS Exclusive)

### Native Control Mode
```bash
# Start tmux in iTerm2 control mode
tmux -CC

# Attach in control mode
tmux -CC attach

# Benefits:
# - Native iTerm2 tabs/windows
# - Persistent across disconnections
# - Full iTerm2 features available
```

## Troubleshooting Guide

### Common Issues and Solutions

#### Issue: "failed to connect to server"
```bash
# Server not running, start new session
tmux new
```

#### Issue: Clipboard not working
```bash
# Check if reattach-to-user-namespace needed
brew install reattach-to-user-namespace

# Test clipboard
echo "test" | pbcopy
pbpaste  # Should output "test"
```

#### Issue: Escape key delay in vim
```bash
# Add to ~/.tmux.conf
set -sg escape-time 0
```

#### Issue: Colors look wrong
```bash
# Add to ~/.tmux.conf
set -g default-terminal "screen-256color"
set-option -sa terminal-overrides ',xterm-256color:RGB'
```

## Best Practices for AI Implementation

### When Creating tmux Configuration
1. **VERIFY** existing ~/.tmux.conf before overwriting
2. **PRESERVE** user customizations when editing
3. **TEST** configuration with `tmux source-file ~/.tmux.conf`
4. **DOCUMENT** changes with comments in configuration

### When Writing Scripts
1. **CHECK** if session exists: `tmux has-session -t session_name 2>/dev/null`
2. **USE** `-d` flag to create detached sessions
3. **IMPLEMENT** error handling for failed commands
4. **QUOTE** session names to handle special characters

### Session Naming Conventions
- **AVOID** spaces in session names (causes scripting issues)
- **USE** underscores or hyphens: `dev_server`, `project-name`
- **IMPLEMENT** consistent naming patterns

## Quick Reference Card

### Most Used Operations
```bash
# Start/Attach
tmux                    # New session
tmux a                  # Attach to last
tmux a -t name          # Attach to specific

# Inside tmux (all require Ctrl+b prefix)
d                       # Detach
c                       # New window
n/p                     # Next/Previous window
%/"                     # Split vertical/horizontal
arrows                  # Navigate panes
z                       # Zoom pane
x                       # Kill pane
&                       # Kill window
```

### Configuration Reload
```bash
# Command line
tmux source-file ~/.tmux.conf

# Inside tmux (if bound)
Ctrl+b r
```

## Version-Specific Notes

### Checking Version
```bash
tmux -V
```

### Version 3.0+ Features
- Curly braces `{}` in configuration
- Improved mouse support
- Better clipboard integration

### Legacy Support
- Versions < 2.4: Different copy-mode syntax
- Versions < 3.0: No curly brace support in config

## Performance Optimization

### For Large Scrollback
```bash
# Limit history to prevent memory issues
set -g history-limit 5000  # Adjust based on needs
```

### For Many Panes
```bash
# Disable activity monitoring if not needed
setw -g monitor-activity off
set -g visual-activity off
```

## Security Considerations

### Session Locking
```bash
# Lock session (requires password)
Ctrl+b :lock-session

# Set lock command
set -g lock-command vlock
```

### Restricted Commands
```bash
# Disable certain commands in shared environments
set -g command-alias[10] kill-server='confirm-before kill-server'
```

## Integration with Development Tools

### Git Status in Status Bar
```bash
# Add to ~/.tmux.conf
set -g status-right '#(cd #{pane_current_path}; git rev-parse --abbrev-ref HEAD 2>/dev/null)'
```

### Current Directory in New Panes
```bash
# Open new panes in current directory
bind '%' split-window -h -c '#{pane_current_path}'
bind '"' split-window -v -c '#{pane_current_path}'
```

## Debugging tmux

### Show Current Settings
```bash
tmux show-options -g        # Global options
tmux show-options -w        # Window options
tmux show-options -s        # Server options
```

### List Key Bindings
```bash
tmux list-keys              # All key bindings
tmux list-keys -T copy-mode-vi  # Specific table
```

### Server Information
```bash
tmux info                   # Display server information
tmux display-message -p '#{version}'  # Show version
```

## AI Agent Implementation Checklist

When implementing tmux functionality:

- [ ] **VERIFY** tmux is installed: `command -v tmux`
- [ ] **CHECK** for existing configuration: `test -f ~/.tmux.conf`
- [ ] **BACKUP** configuration before modifications: `cp ~/.tmux.conf ~/.tmux.conf.backup`
- [ ] **TEST** all commands in isolated session first
- [ ] **VALIDATE** clipboard integration works with pbcopy/pbpaste
- [ ] **ENSURE** TPM is installed before adding plugins
- [ ] **RELOAD** configuration after changes
- [ ] **DOCUMENT** any custom key bindings or modifications

## Summary

tmux is a powerful terminal multiplexer essential for:
- **Remote Work**: Session persistence across SSH disconnections
- **Development**: Managing multiple terminal contexts
- **Automation**: Scriptable terminal environment setup
- **Productivity**: Efficient terminal workspace management

On macOS, special attention required for:
- UTF-8 support (install utf8proc)
- Clipboard integration (configure pbcopy/pbpaste)
- iTerm2 control mode option
- reattach-to-user-namespace for older versions

This guide provides comprehensive tmux knowledge structured for AI agent implementation with precise commands, configurations, and macOS-specific considerations.
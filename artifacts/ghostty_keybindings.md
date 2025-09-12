# Ghostty Keybindings Complete Reference

## Overview

Ghostty provides extensive keybinding customization through its configuration system. This document covers all aspects of keybinding configuration, from basic syntax to advanced features and common configurations.

## Configuration File Location

Ghostty configuration files are located at:
- **macOS**: `~/Library/Application Support/com.mitchellh.ghostty/config`
- **Linux/Unix**: `$XDG_CONFIG_HOME/ghostty/config` or `~/.config/ghostty/config`

You can open the configuration file directly with: `ghostty +open-config`
Reload configuration at runtime with: `Cmd+Shift+,` (macOS) or `Ctrl+Shift+,` (Linux)

## Basic Keybinding Syntax

The basic syntax for keybindings follows this format:

```
keybind = trigger=action[:parameter]
```

### Examples:
```
keybind = ctrl+c=copy_to_clipboard
keybind = super+t=new_tab
keybind = ctrl+shift+v=paste_from_clipboard
keybind = alt+1=goto_tab:1
```

## Key Modifiers

Valid modifiers and their aliases:
- `shift`
- `ctrl` (aliases: `control`)
- `alt` (aliases: `opt`, `option`)  
- `super` (aliases: `cmd`, `command`)

### Platform Notes:
- **macOS**: `super` maps to the Command key (⌘)
- **Linux**: `super` maps to the Super/Windows key

## Special Key Names

Ghostty supports various special key names:
- `enter`, `return`
- `space`
- `tab`
- `backspace`
- `delete`
- `escape`
- `up`, `down`, `left`, `right`
- `page_up`, `page_down`
- `home`, `end`
- `f1` through `f12`
- `physical:key` - Binds to physical key position

### Physical Key Mapping
Use the `physical:` prefix to bind to physical key positions rather than translated keys:
```
keybind = super+physical:one=goto_tab:1
keybind = super+physical:two=goto_tab:2
```

## Special Prefixes

Keybindings can be modified with special prefixes:

### 1. `all:` - Apply to All Surfaces
Makes the keybind apply to all terminal surfaces, not just the focused one:
```
keybind = all:ctrl+c=copy_to_clipboard
```

### 2. `global:` - System-wide Keybinds (macOS only)
Creates global shortcuts that work system-wide (requires accessibility permissions):
```
keybind = global:ctrl+alt+t=new_window
```

### 3. `unconsumed:` - Pass Through to Terminal
Allows the keybind action to execute while also sending the key to the terminal program:
```
keybind = unconsumed:ctrl+a=reload_config
```

### 4. `performable:` - Conditional Execution
Only consumes input if the action can be performed (e.g., only copy if there's a selection):
```
keybind = performable:ctrl+c=copy_to_clipboard
```

### Combining Prefixes
Multiple prefixes can be combined:
```
keybind = global:unconsumed:ctrl+a=reload_config
```

## Trigger Sequences

Ghostty supports multi-key sequences using the `>` separator:

```
keybind = ctrl+a>n=new_window
keybind = ctrl+a>h=new_split:left
keybind = ctrl+b>c=new_tab
keybind = ctrl+b>%=new_split:right
```

### Sequence Features:
- No timeout for completion
- Cannot be used with `global:` or `all:` prefixes
- Prefix keys can override previous bindings
- Indefinite wait for next key in sequence

## Available Actions

### Terminal Interaction
- `ignore` - Do nothing (disable a keybind)
- `unbind` - Remove a previous keybind
- `text:string` - Send literal text to terminal
- `csi:sequence` - Send CSI escape sequence
- `esc:sequence` - Send escape sequence
- `cursor_key:direction` - Send cursor key based on mode
- `reset` - Reset terminal state

### Clipboard Operations
- `copy_to_clipboard` - Copy selection to clipboard
- `paste_from_clipboard` - Paste from clipboard
- `paste_from_selection` - Paste from selection buffer (X11)
- `copy_url_to_clipboard` - Copy URL under cursor

### Font and Display
- `increase_font_size:amount` - Increase font size (default: 1)
- `decrease_font_size:amount` - Decrease font size (default: 1)
- `reset_font_size` - Reset to configured font size
- `clear_screen` - Clear screen and scrollback
- `select_all` - Select all terminal content

### Scrolling and Navigation
- `scroll_to_top` - Scroll to beginning of scrollback
- `scroll_to_bottom` - Scroll to end (current prompt)
- `scroll_page_up` - Scroll up one page
- `scroll_page_down` - Scroll down one page
- `scroll_page_fractional:amount` - Scroll fractional page (e.g., 0.5)
- `scroll_page_lines:count` - Scroll specific number of lines
- `adjust_selection:direction` - Adjust text selection
- `jump_to_prompt:direction` - Jump to previous/next prompt (-1/1)

### File Operations
- `write_scrollback_file:action` - Write scrollback to file
- `write_screen_file:action` - Write screen contents to file
- `write_selection_file:action` - Write selection to file

Actions for file operations: `open`, `paste`, `print`

### Window Management
- `new_window` - Create new window
- `close_window` - Close current window
- `close_all_windows` - Close all windows
- `toggle_fullscreen` - Toggle fullscreen mode
- `toggle_maximize` - Maximize/restore window
- `toggle_window_decorations` - Show/hide title bar
- `toggle_secure_input` - Toggle secure input mode
- `toggle_quick_terminal` - Toggle quick terminal
- `toggle_visibility` - Show/hide Ghostty

### Tab Management
- `new_tab` - Create new tab
- `close_tab` - Close current tab
- `previous_tab` - Switch to previous tab
- `next_tab` - Switch to next tab
- `last_tab` - Switch to last active tab
- `goto_tab:number` - Go to specific tab (1-based)
- `move_tab:direction` - Move tab left/right
- `toggle_tab_overview` - Show tab overview

### Split Management
- `new_split:direction` - Create new split (up/down/left/right)
- `close_surface` - Close current split/tab
- `goto_split:direction` - Navigate splits (up/down/left/right/previous/next)
- `toggle_split_zoom` - Zoom current split
- `resize_split:direction,amount` - Resize split
- `equalize_splits` - Make all splits equal size

### System and Configuration
- `inspector:action` - Toggle inspector (toggle/show/hide)
- `open_config` - Open configuration file
- `reload_config` - Reload configuration
- `quit` - Quit Ghostty
- `crash` - Force crash (debugging)

## Default macOS Keybindings

Here are the default keybindings on macOS:

### Basic Operations
```
keybind = super+c=copy_to_clipboard
keybind = super+v=paste_from_clipboard
keybind = super+shift+v=paste_from_selection
keybind = super+a=select_all
keybind = super+q=quit
keybind = super+k=clear_screen
```

### Font Control
```
keybind = super+equal=increase_font_size:1
keybind = super+plus=increase_font_size:1
keybind = super+minus=decrease_font_size:1
keybind = super+zero=reset_font_size
```

### Window and Fullscreen
```
keybind = super+n=new_window
keybind = super+shift+w=close_window
keybind = super+alt+shift+w=close_all_windows
keybind = super+enter=toggle_fullscreen
keybind = super+ctrl+f=toggle_fullscreen
```

### Tab Management
```
keybind = super+t=new_tab
keybind = super+w=close_surface
keybind = super+alt+w=close_tab
keybind = super+shift+left_bracket=previous_tab
keybind = super+shift+right_bracket=next_tab
keybind = ctrl+tab=next_tab
keybind = ctrl+shift+tab=previous_tab
```

### Tab Navigation (by number)
```
keybind = super+physical:one=goto_tab:1
keybind = super+physical:two=goto_tab:2
keybind = super+physical:three=goto_tab:3
keybind = super+physical:four=goto_tab:4
keybind = super+physical:five=goto_tab:5
keybind = super+physical:six=goto_tab:6
keybind = super+physical:seven=goto_tab:7
keybind = super+physical:eight=goto_tab:8
keybind = super+physical:nine=last_tab
```

### Split Management
```
keybind = super+d=new_split:right
keybind = super+shift+d=new_split:down
keybind = super+shift+enter=toggle_split_zoom
keybind = super+left_bracket=goto_split:previous
keybind = super+right_bracket=goto_split:next
keybind = super+alt+left=goto_split:left
keybind = super+alt+right=goto_split:right
keybind = super+alt+up=goto_split:up
keybind = super+alt+down=goto_split:down
```

### Split Resizing
```
keybind = super+ctrl+left=resize_split:left,10
keybind = super+ctrl+right=resize_split:right,10
keybind = super+ctrl+up=resize_split:up,10
keybind = super+ctrl+down=resize_split:down,10
keybind = super+ctrl+equal=equalize_splits
```

### Scrolling
```
keybind = super+home=scroll_to_top
keybind = super+end=scroll_to_bottom
keybind = super+page_up=scroll_page_up
keybind = super+page_down=scroll_page_down
```

### Text Navigation
```
keybind = super+left=text:\x01        # Beginning of line
keybind = super+right=text:\x05       # End of line
keybind = super+backspace=text:\x15   # Delete line
keybind = alt+left=esc:b              # Word back
keybind = alt+right=esc:f             # Word forward
```

### Selection Adjustment
```
keybind = shift+up=adjust_selection:up
keybind = shift+down=adjust_selection:down
keybind = shift+left=adjust_selection:left
keybind = shift+right=adjust_selection:right
keybind = shift+home=adjust_selection:home
keybind = shift+end=adjust_selection:end
keybind = shift+page_up=adjust_selection:page_up
keybind = shift+page_down=adjust_selection:page_down
```

### Prompt Navigation
```
keybind = super+up=jump_to_prompt:-1
keybind = super+down=jump_to_prompt:1
keybind = super+shift+up=jump_to_prompt:-1
keybind = super+shift+down=jump_to_prompt:1
```

### Configuration and Inspector
```
keybind = super+comma=open_config
keybind = super+shift+comma=reload_config
keybind = super+alt+i=inspector:toggle
```

### File Operations
```
keybind = super+shift+j=write_screen_file:paste
keybind = super+alt+shift+j=write_screen_file:open
```

### Special Keys
```
keybind = shift+enter=text:\x1b\r     # Send ESC+Enter
```

## Common Configuration Examples

### Tmux-Style Configuration

Replace tmux with Ghostty's built-in splits and tabs:

```
# Tmux-style prefix key sequences
keybind = ctrl+a>c=new_tab
keybind = ctrl+a>n=next_tab
keybind = ctrl+a>p=previous_tab
keybind = ctrl+a>x=close_surface
keybind = ctrl+a>d=close_surface

# Split management
keybind = ctrl+a>%=new_split:right
keybind = ctrl+a>\"=new_split:down
keybind = ctrl+a>h=goto_split:left
keybind = ctrl+a>j=goto_split:down
keybind = ctrl+a>k=goto_split:up
keybind = ctrl+a>l=goto_split:right

# Split resizing
keybind = ctrl+a>shift+h=resize_split:left,5
keybind = ctrl+a>shift+j=resize_split:down,5
keybind = ctrl+a>shift+k=resize_split:up,5
keybind = ctrl+a>shift+l=resize_split:right,5

# Other tmux-like commands
keybind = ctrl+a>r=reload_config
keybind = ctrl+a>z=toggle_split_zoom
keybind = ctrl+a>?=inspector:toggle
```

### Vim-Style Navigation

For users who prefer vim-like keybindings:

```
# Split navigation with leader key
keybind = ctrl+w>h=goto_split:left
keybind = ctrl+w>j=goto_split:down
keybind = ctrl+w>k=goto_split:up
keybind = ctrl+w>l=goto_split:right

# Split creation
keybind = ctrl+w>s=new_split:down
keybind = ctrl+w>v=new_split:right
keybind = ctrl+w>q=close_surface

# Split resizing
keybind = ctrl+w>shift+h=resize_split:left,5
keybind = ctrl+w>shift+j=resize_split:down,5
keybind = ctrl+w>shift+k=resize_split:up,5
keybind = ctrl+w>shift+l=resize_split:right,5

# Equal splits
keybind = ctrl+w>=equalize_splits
```

### Linux-Style Configuration

Adjust keybindings for Linux users:

```
# Use Ctrl instead of Super/Cmd
keybind = ctrl+shift+c=copy_to_clipboard
keybind = ctrl+shift+v=paste_from_clipboard
keybind = ctrl+shift+t=new_tab
keybind = ctrl+shift+w=close_surface
keybind = ctrl+shift+n=new_window
keybind = ctrl+shift+q=quit

# Alt-based shortcuts
keybind = alt+1=goto_tab:1
keybind = alt+2=goto_tab:2
keybind = alt+3=goto_tab:3
keybind = alt+4=goto_tab:4
keybind = alt+5=goto_tab:5

# Function key shortcuts
keybind = f11=toggle_fullscreen
keybind = f12=inspector:toggle
```

### Power User Configuration

Advanced configuration for heavy terminal users:

```
# Quick access to frequently used features
keybind = ctrl+alt+t=new_window
keybind = ctrl+alt+n=new_tab
keybind = ctrl+alt+w=close_surface

# Global shortcuts (macOS only, requires accessibility permissions)
keybind = global:ctrl+alt+space=toggle_quick_terminal
keybind = global:ctrl+alt+grave=toggle_visibility

# Advanced split management
keybind = ctrl+shift+d=new_split:right
keybind = ctrl+shift+shift+d=new_split:down
keybind = ctrl+shift+z=toggle_split_zoom
keybind = ctrl+shift+equal=equalize_splits

# File operations
keybind = ctrl+shift+s=write_screen_file:open
keybind = ctrl+shift+alt+s=write_scrollback_file:open
keybind = ctrl+shift+e=write_selection_file:open

# Advanced navigation
keybind = ctrl+shift+up=jump_to_prompt:-1
keybind = ctrl+shift+down=jump_to_prompt:1
keybind = ctrl+shift+home=scroll_to_top
keybind = ctrl+shift+end=scroll_to_bottom

# Font and display
keybind = ctrl+shift+plus=increase_font_size:2
keybind = ctrl+shift+minus=decrease_font_size:2
keybind = ctrl+shift+0=reset_font_size
keybind = ctrl+shift+f=toggle_fullscreen
```

## Tips and Best Practices

### 1. Disable Conflicting Keybinds
Use `ignore` to disable default keybinds you don't want:
```
keybind = super+w=ignore
```

### 2. Conditional Actions
Use `performable:` for actions that might not always be available:
```
keybind = performable:ctrl+c=copy_to_clipboard
keybind = performable:ctrl+v=paste_from_clipboard
```

### 3. Text Insertion Shortcuts
Create shortcuts for frequently typed text:
```
keybind = ctrl+alt+1=text:your.email@example.com
keybind = ctrl+alt+2=text:#!/bin/bash\n
keybind = ctrl+alt+3=text:console.log();
```

### 4. Escape Sequences
Use escape sequences for terminal control:
```
keybind = ctrl+l=csi:H
keybind = alt+enter=text:\x1b\r
```

### 5. Physical Key Bindings
Use physical key positions for consistent layouts across keyboards:
```
keybind = super+physical:grave=toggle_quick_terminal
```

## Troubleshooting

### Common Issues

1. **Keybind not working**: Check for conflicts with system shortcuts
2. **Global keybinds on macOS**: Ensure accessibility permissions are granted
3. **Sequence not completing**: Remember sequences have no timeout
4. **Special characters**: Use escape sequences for control characters

### Debugging Commands

```bash
# List all current keybinds
ghostty +list-keybinds

# Show current configuration
ghostty +show-config

# Show default configuration
ghostty +show-config --default

# List all available actions
ghostty +list-actions

# Validate configuration
ghostty +validate-config
```

## Advanced Examples

### Custom Text Shortcuts
```
keybind = ctrl+alt+g=text:git status\r
keybind = ctrl+alt+l=text:ls -la\r
keybind = ctrl+alt+c=text:clear\r
```

### Multi-Step Sequences
```
keybind = leader>f>f=write_screen_file:open
keybind = leader>f>s=write_scrollback_file:open
keybind = leader>f>c=copy_to_clipboard
```

### Platform-Specific Bindings
```
# macOS-specific
keybind = cmd+opt+i=inspector:toggle

# Linux-specific (using Super key)
keybind = super+return=new_window
```

This comprehensive guide covers all aspects of Ghostty keybinding configuration. Experiment with different combinations to create a setup that matches your workflow and preferences.
# Dotfiles Repository Instructions

## Repository Purpose
This repository contains configuration files (dotfiles) for machine setup and customization. Files stored here are symlinked to their appropriate locations on the system.

## Working with This Repository

### File Operations
- MUST PRESERVE existing configuration syntax and formatting
- MUST VERIFY configuration syntax before committing changes
- SHOULD NOT modify system-specific paths or credentials
- MUST use relative paths within the repository
- SHALL INFER the target symlink location from conventional dotfile paths

### Adding New Configurations
1. MUST place configuration files in logical directory structure
2. SHOULD follow naming convention: remove leading dot for storage (e.g., `.bashrc` → `bashrc`)
3. MUST document the target symlink location in comments or README
4. MAY create subdirectories to organize configs by application or purpose

### Symlink Management
- NEVER create symlinks automatically without explicit user request
- MUST VERIFY target directories exist before suggesting symlink commands
- SHOULD provide both creation and removal commands for symlinks
- SHALL use absolute paths for symlink targets

### Common Dotfile Locations
```
~/.bashrc           → bash/bashrc
~/.zshrc            → zsh/zshrc
~/.gitconfig        → git/gitconfig
~/.vimrc            → vim/vimrc
~/.config/          → config/
~/.ssh/config       → ssh/config
```

### Security Considerations
- MUST NOT commit sensitive data (passwords, API keys, tokens)
- SHOULD use environment variables or separate private files for secrets
- MUST NOT commit SSH private keys or similar authentication files
- MAY include public keys and non-sensitive configurations

### Testing Changes
- SHOULD suggest backing up existing configs before symlinking
- MUST recommend testing configuration changes in isolated environment first
- SHALL provide rollback instructions when making significant changes

### Documentation
- MUST update this file when adding new configuration categories
- SHOULD document any machine-specific requirements
- MAY include setup scripts for automated deployment

## Typical Workflow

1. **Adding a new config file:**
   ```bash
   # Copy config to repo
   cp ~/.configfile configfile
   # Create symlink
   ln -sf $(pwd)/configfile ~/.configfile
   ```

2. **Modifying existing configs:**
   - Edit file in repository
   - Changes reflect immediately via symlink

3. **Setting up new machine:**
   ```bash
   # Clone repository
   git clone [repo-url] ~/dotfiles
   # Run setup script or manually create symlinks
   ```

## Repository Structure Guidelines
- `bash/` - Bash-related configurations
- `zsh/` - Zsh-related configurations  
- `git/` - Git configurations
- `vim/` - Vim configurations
- `config/` - Application configurations (usually from ~/.config/)
- `scripts/` - Setup and utility scripts
- `private/` - Git-ignored directory for sensitive configs

## Notes
- ALWAYS test configuration changes before committing
- PRESERVE comments in configuration files for documentation
- PRIORITIZE portability across different systems
- VERIFY compatibility with target system versions
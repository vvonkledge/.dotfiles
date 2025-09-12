source "$HOME/.cargo/env"

# Claude CLI
alias claude='claude --dangerously-skip-permissions'

# ===== Rust Terminal Tools Aliases =====

# File Search & Navigation (INSTALLED)
alias f='fd'                    # find files
alias rg='rg --smart-case'      # ripgrep with smart case
alias ls='lsd'                   # better ls with icons
alias ll='lsd -la'               # detailed list
alias lt='lsd --tree'            # tree view
alias cat='bat'                  # better cat with syntax highlighting
alias less='bat --paging=always' # use bat for paging

# Directory Navigation (INSTALLED)
alias cd='z'                     # use zoxide for cd
alias zi='__zoxide_zi'           # interactive zoxide
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Git (keep standard git aliases)
alias gd='git diff'              # will use delta if configured
alias gs='git status'
alias gl='git log --oneline --graph --decorate'

# File Management (INSTALLED)
alias y='yazi'                   # modern file manager

# === Tools to install later (commented out) ===
# alias top='btm'                  # bottom - better top
# alias htop='btm'                 # bottom - better htop
# alias ps='procs'                 # better ps
# alias g='gitui'                  # terminal git ui
# alias tl='tldr'                  # tealdeer - simplified man pages
# alias tk='tokei'                 # code statistics
# alias bench='hyperfine'          # benchmarking
# alias cp='xcp'                   # better cp with progress
# alias compress='ouch compress'   # easy compression
# alias decompress='ouch decompress' # easy decompression
# alias update='topgrade'          # update everything

# ===== Shell Enhancements Setup =====


# Zoxide - smarter cd
eval "$(zoxide init zsh)"

# Atuin - shell history database
eval "$(atuin init zsh)"

# ===== Additional Settings =====

# Better history settings for Atuin
export ATUIN_NOBIND="true"
bindkey '^r' atuin-search
bindkey '^[[A' atuin-up-search
bindkey '^[OA' atuin-up-search

# Bat theme
export BAT_THEME="gruvbox-dark"

# Ripgrep config
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/config"

# FZF integration with fd
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'


# Load Sema-inspired minimalist prompt
source "$HOME/workspaces/dotfiles/zsh/sema-prompt.zsh"

# Update RAINFROG configuration location
export RAINFROG_CONFIG=~/.config/rainfrog

# DB connection
edusign_prod() {
    local password=$(security find-generic-password -a "vvonkledge" -s "edusign-production" -w)
    rainfrog --username alexandre_edusign --port 3306 --host edusign-cluster.cluster-c5fznqsdclk6.eu-west-3.rds.amazonaws.com --driver mysql --database production --password "$password"
}

export GPG_TTY=$(tty)

#!/usr/bin/env zsh

# Sema-inspired minimalist prompt for zsh
# Philosophy: Focus on complexity indicators, not decoration

# Enable prompt substitution
setopt PROMPT_SUBST

# Git status function - only show when in repo with changes
git_prompt_info() {
    # Check if in a bare repository (production indicator)
    if git rev-parse --is-bare-repository 2>/dev/null | grep -q true; then
        echo " %F{red}[PRODUCTION]%f"
        return
    fi
    
    # Exit if not in git repo
    git rev-parse --is-inside-work-tree &>/dev/null || return
    
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
    local git_status=""
    
    # Check for uncommitted changes (complexity indicator)
    if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
        git_status="*"
    fi
    
    # Check for unpushed commits (interface with remote)
    local upstream=$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null)
    if [[ -n $upstream ]]; then
        local ahead=$(git rev-list --count @{u}..HEAD 2>/dev/null)
        local behind=$(git rev-list --count HEAD..@{u} 2>/dev/null)
        [[ $ahead -gt 0 ]] && git_status="${git_status}↑"
        [[ $behind -gt 0 ]] && git_status="${git_status}↓"
    fi
    
    [[ -n $branch ]] && echo " ${branch}${git_status}"
}

# Exit code function - only show failures (error-prone indicator)
exit_code_prompt() {
    local code=$?
    [[ $code -ne 0 ]] && echo "%F{red}✗%f "
}

# Directory context - show only when deep (complexity indicator)
dir_prompt() {
    local dir="${PWD/#$HOME/~}"
    local depth=$(echo "$dir" | tr -cd '/' | wc -c)
    
    if [[ $depth -gt 3 ]]; then
        # Show abbreviated path for deep directories
        echo "%F{yellow}…/%1~%f"
    else
        echo "%1~"
    fi
}

# Root user indicator (mutation/privilege indicator)
user_prompt() {
    [[ $UID -eq 0 ]] && echo "%F{red}#%f " || echo ""
}

# Background jobs indicator (control flow complexity)
jobs_prompt() {
    local job_count=$(jobs -l | wc -l | tr -d ' ')
    [[ $job_count -gt 0 ]] && echo "%F{cyan}⚡${job_count}%f "
}

# SSH session indicator (interface/remote context)
ssh_prompt() {
    [[ -n $SSH_CONNECTION ]] && echo "%F{magenta}@%m%f "
}

# Python virtual env indicator (interface context)
venv_prompt() {
    [[ -n $VIRTUAL_ENV ]] && echo "%F{blue}(${VIRTUAL_ENV:t})%f "
}

# Main prompt
PROMPT='$(exit_code_prompt)$(jobs_prompt)$(ssh_prompt)$(venv_prompt)$(user_prompt)$(dir_prompt)$(git_prompt_info) › '

# Minimal right prompt - execution time for long commands
RPROMPT=''

# Command execution time tracking
zmodload zsh/datetime
prompt_preexec() {
    prompt_start_time=$EPOCHREALTIME
}

prompt_precmd() {
    if [[ -n $prompt_start_time ]]; then
        local elapsed=$((EPOCHREALTIME - prompt_start_time))
        unset prompt_start_time
        
        # Only show for commands taking >2 seconds (complexity indicator)
        if [[ $elapsed -gt 2 ]]; then
            local formatted=""
            if [[ $elapsed -gt 60 ]]; then
                formatted="$(printf "%dm%ds" $((elapsed/60)) $((elapsed%60)))"
            else
                formatted="$(printf "%.1fs" $elapsed)"
            fi
            RPROMPT="%F{240}${formatted}%f"
        else
            RPROMPT=''
        fi
    fi
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec prompt_preexec
add-zsh-hook precmd prompt_precmd

# Minimal color scheme - only for complexity indicators
# Red: errors, root user, bare repositories (production)
# Yellow: deep directories  
# Cyan: background jobs
# Magenta: SSH sessions
# Blue: virtual environments
# Gray: execution time
# Default: everything else
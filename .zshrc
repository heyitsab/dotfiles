# ~/.zshrc - Managed by dotfiles repo
# NOTE: Put secrets like GITHUB_TOKEN in ~/.zshrc.local (gitignored)

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# Basic completion
autoload -Uz compinit && compinit

# Aliases (only enable when tools are installed)
command -v nvim &> /dev/null && alias vim="nvim" && alias vi="nvim"
command -v eza &> /dev/null && alias ls="eza" && alias ll="eza -la"
command -v bat &> /dev/null && alias cat="bat"

# Environment variables
export EDITOR="nvim"
export VISUAL="nvim"

# Tool initializations
eval "$(starship init zsh)"
command -v zoxide &> /dev/null && eval "$(zoxide init zsh)" && alias cd="z"
command -v fzf &> /dev/null && eval "$(fzf --zsh)"

# Load local customizations if they exist
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local


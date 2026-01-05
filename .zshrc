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
command -v nvim &> /dev/null && alias vim="nvim" && alias vi="nvim" && alias v="nvim"
command -v eza &> /dev/null && alias ls="eza" && alias ll="eza -la"
command -v bat &> /dev/null && alias cat="bat"
command -v gh &> /dev/null && alias ghcs="TERM=xterm-256color gh cs ssh"

# Environment variables
export EDITOR="nvim"
export VISUAL="nvim"

# Use Homebrew Ruby (not system Ruby)
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/lib/ruby/gems/4.0.0/bin:$PATH"

# Tool initializations
eval "$(starship init zsh)"
command -v zoxide &> /dev/null && eval "$(zoxide init zsh)" && alias cd="z"
command -v fzf &> /dev/null && eval "$(fzf --zsh)"
command -v thefuck &> /dev/null && eval "$(thefuck --alias)"

# Load local customizations if they exist
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local


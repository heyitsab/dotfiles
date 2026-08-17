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

# GitHub Codespaces shortcuts
if command -v gh &> /dev/null; then
  alias ghcs="TERM=xterm-256color gh cs ssh -- -t"
  alias ghcsl="gh cs list"
  alias ghcsp="gh cs ports"
  alias ghcsf="gh cs ports forward"
  
  # Quick SSH to most recent codespace
  ccs() {
    gh cs ssh -c $(gh cs list --json name --jq '.[0].name')
  }
fi

# Environment variables
export EDITOR="nvim"
export VISUAL="nvim"

# Homebrew paths (macOS only)
if [[ "$OSTYPE" == "darwin"* ]]; then
  export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
  export PATH="/opt/homebrew/lib/ruby/gems/4.0.0/bin:$PATH"
fi

# Add local bin to path (for tools installed via curl)
export PATH="$HOME/.local/bin:$PATH"

# Tool initializations
command -v starship &> /dev/null && eval "$(starship init zsh)"
command -v zoxide &> /dev/null && eval "$(zoxide init zsh)" && alias cd="z"
command -v fzf &> /dev/null && eval "$(fzf --zsh)"
command -v pay-respects &> /dev/null && eval "$(pay-respects zsh --alias)"

# Load local customizations if they exist
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local


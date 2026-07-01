# ~/.bashrc - Managed by dotfiles repo
# NOTE: Put secrets like GITHUB_TOKEN in ~/.bashrc.local (gitignored)

# History settings
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s histappend

# Basic aliases (only enable when tools are installed)
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

# Homebrew setup (macOS)
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
  export PATH="/opt/homebrew/lib/ruby/gems/4.0.0/bin:$PATH"
fi

# Tool initializations
command -v starship &> /dev/null && eval "$(starship init bash)"
command -v zoxide &> /dev/null && eval "$(zoxide init bash)" && alias cd="z"
command -v fzf &> /dev/null && eval "$(fzf --bash)"
command -v thefuck &> /dev/null && eval "$(thefuck --alias)"

# Load local customizations if they exist
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local

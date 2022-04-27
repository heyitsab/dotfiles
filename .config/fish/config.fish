if status --is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source
alias config='/usr/bin/git --git-dir=$HOME/.myconfig/ --work-tree=$HOME'

# Git shortcuts
alias g='git'
alias gco='git checkout'
alias gsta='git stash'
alias gdiff='git diff'

# Set terminal when SSH-ing into codespace
alias csssh='TERM=xterm-256color gh cs ssh'

set -x VIMINIT 'source $HOME/.config/vim/.vimrc'

if set -q CODESPACES
else
        source /usr/local/opt/asdf/libexec/asdf.fish
end

eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)

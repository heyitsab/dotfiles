#!/bin/bash
# Dotfiles installer - creates symlinks from home directory to dotfiles

set -e

DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

echo "🔗 Installing dotfiles..."

# Install starship if not already installed
if ! command -v starship &> /dev/null; then
    echo "📦 Installing starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

# Backup existing files
backup_if_exists() {
    local file="$1"
    if [[ -e "$file" && ! -L "$file" ]]; then
        mkdir -p "$BACKUP_DIR"
        echo "📦 Backing up existing $(basename $file) to $BACKUP_DIR"
        mv "$file" "$BACKUP_DIR/"
    fi
}

# Create symlink
link_file() {
    local src="$1"
    local dest="$2"
    backup_if_exists "$dest"
    mkdir -p "$(dirname "$dest")"
    ln -sf "$src" "$dest"
    echo "✅ Linked $src -> $dest"
}

# Link dotfiles
link_file "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
link_file "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml"
link_file "$DOTFILES_DIR/.config/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
link_file "$DOTFILES_DIR/.config/tmux/tmux.conf" "$HOME/.tmux.conf"
link_file "$DOTFILES_DIR/.config/nvim/init.vim" "$HOME/.config/nvim/init.vim"

echo ""
echo "✨ Dotfiles installation complete!"
echo ""
echo "Next steps:"
echo "1. Restart your terminal or run: source ~/.zshrc"
echo "2. Install packages: brew bundle install"
echo "3. Configure ghostty through its settings UI"

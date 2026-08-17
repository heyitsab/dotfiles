#!/bin/bash
# Dotfiles installer - creates symlinks from home directory to dotfiles

set -e

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

echo "🔗 Installing dotfiles..."

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
else
    OS="linux"
fi

echo "📦 Detected OS: $OS"

# Install essential tools based on OS
if [[ "$OS" == "linux" ]]; then
    echo "📦 Installing Linux packages..."
    sudo apt-get update -qq
    sudo apt-get install -y zsh curl git build-essential &> /dev/null || true
    
    # Install starship
    if ! command -v starship &> /dev/null; then
        echo "📦 Installing starship..."
        curl -sS https://starship.rs/install.sh | sh -s -- -y
    fi
    
    # Install eza (modern ls)
    if ! command -v eza &> /dev/null; then
        echo "📦 Installing eza..."
        sudo apt-get install -y gpg
        sudo mkdir -p /etc/apt/keyrings
        wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
        echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
        sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
        sudo apt-get update -qq
        sudo apt-get install -y eza
    fi
    
    # Install fzf
    if ! command -v fzf &> /dev/null; then
        if [ ! -d ~/.fzf ]; then
            echo "📦 Installing fzf..."
            git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
            ~/.fzf/install --all --no-bash --no-fish
        else
            echo "⚠️  fzf directory exists, running install script..."
            ~/.fzf/install --all --no-bash --no-fish
        fi
    fi
    
    # Install zoxide
    if ! command -v zoxide &> /dev/null; then
        echo "📦 Installing zoxide..."
        curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
    fi
    
    # Install pay-respects (modern, maintained thefuck alternative)
    if ! command -v pay-respects &> /dev/null; then
        echo "📦 Installing pay-respects..."
        curl -sSfL https://raw.githubusercontent.com/iffse/pay-respects/main/install.sh | sh
    fi
    
    # Install lazygit
    if ! command -v lazygit &> /dev/null; then
        echo "📦 Installing lazygit..."
        LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
        curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
        tar xf lazygit.tar.gz lazygit
        sudo install lazygit /usr/local/bin
        rm lazygit lazygit.tar.gz
    fi
    
    # Install bat (better cat)
    if ! command -v bat &> /dev/null && ! command -v batcat &> /dev/null; then
        echo "📦 Installing bat..."
        sudo apt-get install -y bat
        # Create alias since Ubuntu calls it batcat
        mkdir -p ~/.local/bin
        ln -sf /usr/bin/batcat ~/.local/bin/bat 2>/dev/null || true
    fi
    
elif [[ "$OS" == "macos" ]]; then
    # Install starship on macOS
    if ! command -v starship &> /dev/null; then
        echo "📦 Installing starship..."
        curl -sS https://starship.rs/install.sh | sh -s -- -y
    fi
    echo "💡 Run 'brew bundle install' to install remaining packages"
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
link_file "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
link_file "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml"

# Link tmux config to modern location first
link_file "$DOTFILES_DIR/.config/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
# Then link legacy location to the modern one for compatibility
rm -f "$HOME/.tmux.conf"  # Remove if it's a regular file
ln -sf "$HOME/.config/tmux/tmux.conf" "$HOME/.tmux.conf"
echo "✅ Linked $HOME/.config/tmux/tmux.conf -> $HOME/.tmux.conf"

link_file "$DOTFILES_DIR/.config/nvim/init.vim" "$HOME/.config/nvim/init.vim"
link_file "$DOTFILES_DIR/.copilot/copilot-instructions.md" "$HOME/.copilot/copilot-instructions.md"

if [[ "${CODESPACES:-false}" == "true" ]]; then
    "$DOTFILES_DIR/scripts/setup-copilot-codespaces.sh"
fi

# Change default shell to zsh (Codespaces and Linux)
if [[ "$SHELL" != *"zsh"* ]]; then
    echo "🐚 Changing default shell to zsh..."
    if command -v zsh &> /dev/null; then
        sudo chsh -s "$(which zsh)" "$USER" || echo "⚠️  Could not change shell (may need manual setup)"
    fi
fi

echo ""
echo "✨ Dotfiles installation complete!"
echo ""
if [[ "$OS" == "linux" ]]; then
    echo "Next steps:"
    echo "1. Restart your terminal (or run: exec zsh)"
    echo "2. Open nvim and run: :PlugInstall"
else
    echo "Next steps:"
    echo "1. Restart your terminal or run: exec zsh"
    echo "2. Install packages: brew bundle install"
    echo "3. Open nvim and run: :PlugInstall"
fi

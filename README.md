# Dotfiles

My personal development environment configuration for macOS.

## Tools
- **Shell**: zsh with starship prompt
- **Editor**: neovim
- **Terminal**: ghostty
- **Multiplexer**: tmux

## Quick Setup

```bash
# Install Homebrew (if needed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Clone this repo
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Install packages
brew bundle install

# Create symlinks
./install.sh

# Restart terminal
```

## Structure

```
dotfiles/
├── Brewfile              # Homebrew packages
├── .zshrc                # Shell configuration
├── .config/
│   ├── starship.toml     # Prompt configuration
│   ├── nvim/             # Neovim configuration
│   │   └── init.vim
│   └── tmux/             # Tmux configuration
│       └── tmux.conf
└── install.sh            # Symlink installer
```

## Manual Steps

After running `install.sh`:
1. Open ghostty and configure it via settings UI
2. Customize configs as needed
3. Add local overrides to `~/.zshrc.local` (gitignored)

## Key Bindings

### Tmux (prefix: Ctrl-a)
- `Ctrl-a |` - Split vertically
- `Ctrl-a -` - Split horizontally
- `Ctrl-a h/j/k/l` - Navigate panes
- `Ctrl-a r` - Reload config

### Neovim (leader: Space)
- `Space w` - Save
- `Space q` - Quit
- `Space h` - Clear search highlight
- `Ctrl-h/j/k/l` - Navigate splits

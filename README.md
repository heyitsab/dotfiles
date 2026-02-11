# Dotfiles

My personal development environment configuration for **macOS** and **Linux** (including GitHub Codespaces).

> **Dad Joke:** Why do programmers prefer dark mode? Because light attracts bugs! 🐛
>
> **Chiste de Papá:** ¿Por qué los programadores prefieren el modo oscuro? ¡Porque la luz atrae bichos! 🐛
>
> **Αστείο Μπαμπά:** Γιατί οι προγραμματιστές προτιμούν τη σκοτεινή λειτουργία; Επειδή το φως προσελκύει κοριούς! 🐛

## Tools
- **Shell**: zsh with starship prompt
- **Editor**: neovim with LSP support
- **Terminal**: ghostty (macOS) / built-in (Linux)
- **Multiplexer**: tmux

## Quick Setup

### macOS
```bash
# Install Homebrew (if needed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Clone this repo
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Install packages
brew bundle install

# Create symlinks and configure
./install.sh

# Restart terminal
exec zsh
```

### Linux / GitHub Codespaces
```bash
# Clone this repo (or configure as Codespaces dotfiles repo)
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Install everything (auto-detects Linux)
./install.sh

# Restart terminal
exec zsh
```

**For Codespaces**: Set your dotfiles repo in [GitHub Settings → Codespaces](https://github.com/settings/codespaces) and it will auto-install on every new codespace.

## Structure

```
dotfiles/
├── Brewfile              # Homebrew packages (macOS)
├── .zshrc                # Shell configuration
├── .bashrc               # Bash fallback
├── .config/
│   ├── starship.toml     # Prompt configuration
│   ├── nvim/             # Neovim configuration
│   │   └── init.vim
│   └── tmux/             # Tmux configuration
│       └── tmux.conf
└── install.sh            # Cross-platform installer
```

## What Gets Installed

### macOS (via Homebrew)
- Core: tmux, neovim, git, starship, fzf, ripgrep
- Modern tools: eza, bat, zoxide, fd
- Language support: node, go, ruby
- Terminal: ghostty

### Linux (via apt/curl)
- Core: zsh, neovim, git, starship, fzf, eza
- Build tools: build-essential
- Other tools: zoxide, ripgrep (when available)

## Manual Steps

After running `install.sh`:
1. macOS: Configure ghostty via settings UI
2. Open nvim and wait for plugins to install
3. Add local overrides to `~/.zshrc.local` (gitignored)

## Key Bindings

### Tmux (prefix: Ctrl-s)
- `Ctrl-s |` - Split vertically
- `Ctrl-s -` - Split horizontally
- `Ctrl-h/j/k/l` - Navigate panes (works with vim!)
- `Ctrl-s r` - Reload config
- `Ctrl-s [` - Enter copy mode
- `v` (in copy mode) - Start selection
- `y` (in copy mode) - Copy selection
- `Ctrl-s ]` - Paste

### Neovim - Navigation
- `Ctrl-d` / `Ctrl-u` - Scroll down/up (keeps cursor centered)
- `zt` - Move current line to top of screen
- `zz` - Move current line to center of screen
- `zb` - Move current line to bottom of screen
- `n` / `N` - Next/previous search (centered)

### Neovim - Leader Keys (leader: ,)
- `,w` - Save
- `Space q` - Quit
- `Space h` - Clear search highlight
- `Ctrl-h/j/k/l` - Navigate splits

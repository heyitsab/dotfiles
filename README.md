# Dotfiles

My personal development environment configuration for **macOS** and **Linux** (including GitHub Codespaces).

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

### Copilot Brain in Codespaces

The Codespaces installer can clone the private `heyitsab/copilot-brain` repository into `~/Documents/Copilot Brain` and configure a read-only `copilot-brain` MCP server.

Create a fine-grained personal access token with:

- Repository access: only `heyitsab/copilot-brain`
- Repository permission: Contents, read-only

Store it as a Codespaces user secret named `COPILOT_BRAIN_TOKEN` and grant it to the repositories where Codespaces should load the Brain. Do not put the token in this repository or any shell configuration.

The Codespaces setup intentionally does not copy local Slack, Datadog, Splunk, feature-flag, Keychain, or machine-specific permission configuration. The Mac vault remains writable; Codespaces gets read-only MCP access and can safely pull updates. When asked to save a note in Codespaces, Copilot returns the proposed path and content for review instead of claiming it wrote to the vault.

Herdr (the `herdr` CLI binary) is installed by `install.sh` on both macOS and Linux/Codespaces; only credential-bearing local config is excluded from Codespaces, not the tool itself.

### Ponytail

The Codespaces installer also installs the third-party [Ponytail](https://github.com/DietrichGebert/ponytail) Copilot CLI plugin when `copilot` is available. It defaults to `full` mode and adds mode switching plus review, audit, debt, gain, and help skills.

Useful commands:

```text
/ponytail:ponytail lite|full|ultra|off
/ponytail:ponytail-review
```

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
├── .copilot/             # Portable Copilot instructions
│   └── skills/           # Personal Copilot CLI skills
├── scripts/
│   └── setup-copilot-codespaces.sh
└── install.sh            # Cross-platform installer
```

### Personal Copilot Skills

| Skill | Purpose |
| --- | --- |
| `brain-notes` | Researches and saves durable context in Copilot Brain |
| `bruh` | Restates the previous response in concise, plain language |
| `check-feedback` | Evaluates pull request feedback against the codebase |
| `code-walkthrough` | Explains existing code as a mental model |
| `fleet-review` | Runs explicitly requested four-model reviews |
| `herdr` | Controls Herdr using its version-matched command surface |
| `production-proof` | Verifies production claims with direct evidence |
| `stfu` | Removes redundant and conversation-dependent comments |

The Herdr skill is adapted from the upstream skill for the version recorded in
`.copilot/skills/herdr/upstream-version`.

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

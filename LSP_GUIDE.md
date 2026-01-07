# LSP & Completion Setup Guide

## What's Included

✅ **LSP Support** for TypeScript/JavaScript, Go, and Ruby
✅ **Autocompletion** with snippet support
✅ **Format on save** - automatic code formatting
✅ **Auto-imports** - organize imports automatically
✅ **Inline signature help** - see function parameters as you type
✅ **Smart diagnostics** - errors shown on cursor hold, not while typing

## Treesitter

**Out of the box!** Rich syntax highlighting for:
- Go, TypeScript/JavaScript, Ruby, Lua
- JSON, YAML, HTML, CSS, Markdown

Auto-installs language parsers on first use.

## Snippets

**Out of the box!** Uses `friendly-snippets` collection. Examples:
- Type `for` + Tab → for loop
- Type `if` + Tab → if statement
- Type `func` + Tab → function declaration

Press **Tab** to jump between snippet fields.

## Key Bindings

### Navigation
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gt` | Go to type definition |
| `gi` | Go to implementation |
| `gr` | Find references |

### Documentation
| Key | Action |
|-----|--------|
| `K` | Hover documentation |
| `Ctrl-k` | Signature help (while typing) |

### Actions
| Key | Action |
|-----|--------|
| `,r` | Rename symbol |
| `,a` | Code actions |
| `,d` | Show diagnostic details |

### Diagnostics
| Key | Action |
|-----|--------|
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |

### Completion
| Key | Action |
|-----|--------|
| `Tab` | Next completion / jump to next snippet field |
| `Shift-Tab` | Previous completion / jump to previous field |
| `Enter` | Accept completion |
| `Ctrl-e` | Dismiss completion menu |
| `Ctrl-Space` | Manually trigger completion |

## Installation

```bash
# Install Node and Go (for language servers)
brew bundle install

# Open nvim and install new plugins
nvim +PlugInstall +qall

# Language servers will auto-install on first use
# Or manually install via:
nvim
:Mason
```

## Managing Language Servers

Open Mason to install/update language servers:
```vim
:Mason
```

Navigate with `j/k`, press `i` to install, `u` to update, `X` to uninstall.

## Behavior Details

### Formatting
- **Auto-formats on save** for all supported files
- Uses language server's formatter (prettier for JS/TS, gofmt for Go, etc.)

### Imports
- **Auto-organizes imports on save**
- Removes unused imports, sorts them

### Diagnostics (Errors)
- **Not shown while typing** - only when you stop (300ms delay)
- **Hover over error** - details appear in floating window
- **Signs in gutter** - see which lines have issues
- **No red text everywhere** - just underlines

### Signature Help
- Shows function parameters as you type
- Press `Ctrl-k` in insert mode to see signature

## Troubleshooting

**No completions?**
- Language server might still be installing
- Check `:LspInfo` to see server status

**Formatting not working?**
- Ensure language server supports formatting
- Check `:LspInfo` for capabilities

**Errors not showing?**
- Wait 300ms without typing
- Or press `,d` to manually show diagnostic

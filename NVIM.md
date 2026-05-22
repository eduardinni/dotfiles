# eduardinni/config.nvim

A modern Neovim setup with LSP support, fuzzy finding, and a clean UI.

## Features

### UI & Theme
- **Catppuccin Mocha** - Dark theme with soft colors
- **Lualine** - Statusline with LSP progress indicator
- **Barbar** - Buffer/tab management in the sidebar
- **Barbecue** - Breadcrumb navigation in the statusline
- **Alpha-nvim** - Startup screen with recent files

### File Explorer & Navigation
- **Neo-tree** - File browser with icons (auto-opens on startup)
- **Telescope** - Fuzzy finder for files, buffers, and live grep

### LSP & Autocomplete
- **Mason** - Package manager for LSP servers, linters, and formatters
- **nvim-lspconfig** - LSP client configuration
- **nvim-cmp** - Completion engine with LSP and snippet support
- **LuaSnip** - Snippet engine with friendly-snippets

### Installed LSP servers:
- Ruby: `ruby_lsp`, `rubocop`
- JavaScript/TypeScript: `ts_ls`, `eslint`
- Clojure: `clojure_lsp`

### Git Integration
- **vim-fugitive** - Git commands
- **gitsigns** - Git signs in the gutter (additions, deletions, changes)

### Syntax & Formatting
- **Treesitter** - Advanced syntax highlighting and indentation
- **Conform** - Format on save with Prettier (JS/TS) and Rubocop (Ruby)
- **Comment.nvim** - Toggle comments

## Editor Settings

- **Expand tabs** - Convert tabs to spaces
- **Tab width** - 2 spaces
- **Line numbers** - Enabled

## Keymaps

### General
| Key | Action |
|-----|--------|
| `<Space>` | Leader key |
| `<C-h>` | Previous buffer |
| `<C-l>` | Next buffer |
| `<C-x>` | Close current buffer |

### File Explorer (Neo-tree)
| Key | Action |
|-----|--------|
| `<C-n>` | Toggle file explorer |
| `<leader>bf` | Fuzzy search open buffers |

### Fuzzy Finder (Telescope)
| Key | Action |
|-----|--------|
| `<C-p>` | Find files |
| `<leader>fg` | Live grep |
| `<leader><leader>` | Recent files |

### LSP (when LSP attached)
| Key | Action |
|-----|--------|
| `gR` | Show LSP references |
| `gD` | Go to declaration |
| `gd` | Show LSP definition |
| `gi` | Show LSP implementations |
| `gt` | Show LSP type definitions |
| `<leader>ca` | Show code actions |
| `<leader>rn` | Smart rename |
| `<leader>D` | Show buffer diagnostics |
| `<leader>d` | Show line diagnostics |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `K` | Show documentation (hover) |
| `<leader>rs` | Restart LSP |

### Formatting & Comments
| Key | Action |
|-----|--------|
| `<leader>gf` | Format buffer |
| `gc` | Toggle comment (visual) |
| `gcc` | Toggle comment (line) |

## Cheatsheet
| Key | Action |
|-----|--------|
| `C-o` | Prev cursor position |
| `C-i` | Go forward cursor position |
| `*` | Search forward for word under cursor |
| `#` | Search backward for word under cursor |
| `:noh` | Clear the highlights |
| `n` `N` | Navigate through search |


# eduardinni/dotfiles

Custom configuration for my dev env, includes zsh and iTerm configs.

# Installation

- Install Homebrew
- `brew install neovim tmux ripgrep fzf`

### zsh config

```bash
echo '\nsource /Users/eduardo/projects/dotfiles/bash/zshrc' >> ~/.zshrc
```

### neovim config

```bash
ln -s $EDU_DOTFILES/nvim ~/.config/nvim
```

### tmux config

```bash
mkdir ~/.config/tmux && ln -s $EDU_DOTFILES/tmux/tmux.conf ~/.config/tmux/tmux.conf
```

# tmux Keymap Reference

## Prefix
| Key | Action |
|-----|--------|
| `C-s` | Primary prefix (default) |
| `C-b` | Secondary prefix |

## General
| Key | Action |
|-----|--------|
| `q` | Reload config |

## Pane Controls
| Key | Action |
|-----|--------|
| `h` | Split pane vertically |
| `v` | Split pane horizontally |
| `x` | Kill current pane |

## Window Controls
| Key | Action |
|-----|--------|
| `c` | New window |
| `r` | Rename window |
| `k` | Kill window |

## Copy Mode (Vi)
| Key | Action |
|-----|--------|
| `v` | Begin selection |
| `y` | Copy selection |

- Enter copy mode (`Ctrl+b [`)
- Move with `h j k l`
- `v` → select
- `y` → yank (copy) and quit
- `q` → exit copy mode

# iTerm

![iTerm_1](screenshots/iterm_1.png)
![iTerm_2](screenshots/iterm_2.png)
![iTerm_3](screenshots/iterm_3.png)
![iTerm_4](screenshots/iterm_4.png)

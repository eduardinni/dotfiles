#!/usr/bin/env bash
#
# install.sh - Bootstrap eduardinni development environment
#
# Usage:
#   ./install.sh
#
set -euo pipefail

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------
info()  { printf '\033[1;34m[INFO]\033[0m %s\n' "$1"; }
warn()  { printf '\033[1;33m[WARN]\033[0m %s\n' "$1"; }
error() { printf '\033[1;31m[ERROR]\033[0m %s\n' "$1" >&2; }

# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------
EDU_DOTFILES="$HOME/projects/dotfiles"

info "Using EDU_DOTFILES=${EDU_DOTFILES}"

# ---------------------------------------------------------------------------
# 1. Install Homebrew
# ---------------------------------------------------------------------------
if ! command -v brew >/dev/null 2>&1; then
  info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Make brew available in this script's current session
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
else
  info "Homebrew already installed, skipping."
fi

# ---------------------------------------------------------------------------
# 2. Install packages via Homebrew
# ---------------------------------------------------------------------------
info "Installing packages: neovim tmux ripgrep fzf chroma"
brew install neovim tmux ripgrep fzf chroma

# ---------------------------------------------------------------------------
# 3. Create ~/Desktop/Projects and symlink ~/projects -> it
# ---------------------------------------------------------------------------
if [[ ! -d "$HOME/Desktop/Projects" ]]; then
  info "Creating ~/Desktop/Projects"
  mkdir -p "$HOME/Desktop/Projects"
else
  info "~/Desktop/Projects already exists, skipping."
fi

if [[ -e "$HOME/projects" || -L "$HOME/projects" ]]; then
  info "~/projects already exists, skipping symlink."
else
  info "Linking ~/projects -> ~/Desktop/Projects"
  ln -s "$HOME/Desktop/Projects" "$HOME/projects"
fi

# ---------------------------------------------------------------------------
# 4. zsh config
# ---------------------------------------------------------------------------
ZSHRC="$HOME/.zshrc"
touch "$ZSHRC"

info "Configuring ~/.zshrc"

ZSHRC_BEGIN="# >>> eduardinni/dotfiles (managed) >>>"
ZSHRC_END="# <<< eduardinni/dotfiles (managed) <<<"

# Lines managed by this script, always kept together as one block.
# 'source $ZSH/oh-my-zsh.sh' is listed last so it always ends the block.
zshrc_lines=(
  'source $HOME/projects/dotfiles/bash/zshrc'
  'source $ZSH/oh-my-zsh.sh'
)

# Rewrite the managed block from scratch on every run so the lines always
# stay together and 'source $ZSH/oh-my-zsh.sh' always ends the block:
#   1. remove any previously managed block,
#   2. comment out stray 'plugins=(...)' lines and any other
#      'source $ZSH/oh-my-zsh.sh' lines (e.g. those the oh-my-zsh installer
#      adds) so ours stays the only active one, at the end of the block,
#   3. trim trailing blank lines so they don't accumulate across runs.
tmp_zshrc="$(mktemp)"
sed -e "\%^${ZSHRC_BEGIN}$%,\%^${ZSHRC_END}$%d" \
    -e 's/^plugins=(/# plugins=(/' \
    -e 's|^source \$ZSH/oh-my-zsh\.sh|# &|' \
    "$ZSHRC" \
  | awk 'NF {last=NR} {lines[NR]=$0} END {for (i=1; i<=last; i++) print lines[i]}' \
  > "$tmp_zshrc" || true
mv "$tmp_zshrc" "$ZSHRC"

# Append the managed block, with oh-my-zsh.sh at the end.
{
  printf '\n%s\n' "$ZSHRC_BEGIN"
  printf '%s\n' "${zshrc_lines[@]}"
  printf '%s\n' "$ZSHRC_END"
} >> "$ZSHRC"
info "Wrote managed zsh config block to $ZSHRC"

# ---------------------------------------------------------------------------
# 5. oh-my-zsh plugins
# ---------------------------------------------------------------------------
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

clone_plugin() {
  local repo_url="$1"
  local plugin_name="$2"
  local target_dir="${ZSH_CUSTOM}/plugins/${plugin_name}"

  if [[ -d "$target_dir" ]]; then
    info "Plugin '${plugin_name}' already cloned, skipping."
  else
    info "Cloning plugin '${plugin_name}'..."
    git clone "$repo_url" "$target_dir"
  fi
}

info "Installing oh-my-zsh plugins"
clone_plugin "https://github.com/zsh-users/zsh-syntax-highlighting.git" "zsh-syntax-highlighting"
clone_plugin "https://github.com/zsh-users/zsh-autosuggestions" "zsh-autosuggestions"
clone_plugin "https://github.com/zsh-users/zsh-completions" "zsh-completions"
clone_plugin "https://github.com/zsh-users/zsh-history-substring-search" "zsh-history-substring-search"

# ---------------------------------------------------------------------------
# 6. neovim config
# ---------------------------------------------------------------------------
info "Linking neovim config"
mkdir -p "$HOME/.config"
if [[ -e "$HOME/.config/nvim" || -L "$HOME/.config/nvim" ]]; then
  warn "~/.config/nvim already exists, skipping symlink."
else
  ln -s "${EDU_DOTFILES}/nvim" "$HOME/.config/nvim"
fi

# ---------------------------------------------------------------------------
# 7. tmux config
# ---------------------------------------------------------------------------
info "Linking tmux config"
mkdir -p "$HOME/.config/tmux"
if [[ -e "$HOME/.config/tmux/tmux.conf" || -L "$HOME/.config/tmux/tmux.conf" ]]; then
  warn "~/.config/tmux/tmux.conf already exists, skipping symlink."
else
  ln -s "${EDU_DOTFILES}/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
fi

info "Installation complete! Restart your terminal or run: source ~/.zshrc"

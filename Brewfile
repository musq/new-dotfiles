# Modeline hint for vim to improve syntax highlighting of this file
# vim: syntax=sh

# Usage: `brew bundle --no-lock --file /path/to/Brewfile`

# https://docs.brew.sh/Manpage#bundle-subcommand
# https://homebrew-file.readthedocs.io/en/latest/usage.html
# https://github.com/Homebrew/homebrew-bundle#usage

# =====================================================================
# Common
# =====================================================================

brew "bat"
brew "eza"
brew "fd"
brew "forgit"
brew "fzf"
brew "git"
brew "git-delta"
brew "go"
brew "lazygit"
brew "lesspipe"
brew "ncdu"
brew "neovim"
brew "npm"
brew "pass"
brew "poetry"
brew "prettyping"
brew "python3"
brew "ripgrep"
brew "starship"
brew "stow"
brew "tmux"
brew "universal-ctags"
brew "vim"
brew "wormhole-william"
brew "zoxide"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Visidata fails to install during compilation
# tap "saulpw/vd"
# brew "saulpw/vd/visidata"

# =====================================================================
# Linux
# =====================================================================

brew "xclip" if OS.linux?

# =====================================================================
# MacOS
# =====================================================================

cask "gpg-suite" if OS.mac?

# TODO: pinentry-mac is now in a publicly archived state in upstream
# repo, so maybe don't use it now. Check if brew "pinentry" installs
# pinentry-mac or not.
# https://github.com/GPGTools/pinentry-mac
brew "pinentry-mac" if OS.mac?

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# NOTE: Homebrew does not yet support installing Casks on Linux,
# so these packages will be skipped on Linux

cask "alacritty"
cask "brave-browser"
cask "sublime-text"
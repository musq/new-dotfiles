#!/bin/sh

# Unofficial POSIX Shell Strict Mode
# https://gist.github.com/EvgenyOrekhov/5c1418f4710558b5d6717d9e69c6e929
set -o errexit
set -o nounset
IFS=$(printf '\n\t')

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Trap to detect non-zero exit and print error message

trap 'if [ $? -ne 0 ]; then print_error "\n[ERROR] Script exited with error, please check above\n"; fi' EXIT

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Steps (in order):
# - Source common/.bash_utils to acquire util functions necessary to run this setup
# - Install programs/tools using Homebrew
# - Create necessary directories
# - Symlink config files using GNU stow
# - Print instruction for user to backup and remove conflicting GNU stow files
# - Copy *.local files to appropriate locations
# - Harden necessary locations
# - Print further instructions for the user
#   - Manually install named tools using OS' native software manager

# =====================================================================
# Source common/.bash_utils to acquire util functions necessary to run this setup
# =====================================================================

. common/.bash_utils

# =====================================================================
# Install programs/tools using Homebrew
# =====================================================================

print_success "\n========================================================================"
print_success "> Install programs/tools using Homebrew"
print_success "========================================================================\n"

brew bundle --no-lock --file ./Brewfile

# =====================================================================
# Create necessary directories
# =====================================================================

print_success "\n========================================================================"
print_success "> Create necessary directories"
print_success "========================================================================\n"

mkdir -p "$HOME/.config/git"
mkdir -p "$HOME/.gnupg"
mkdir -p "$HOME/.local/state/gnupg"
mkdir -p "$HOME/.local/state/vim/backups"
mkdir -p "$HOME/.local/state/vim/swaps"
mkdir -p "$HOME/.local/state/vim/undos"
mkdir -p "$HOME/.profile.d"
mkdir -p "$HOME/.ssh/sockets"
mkdir -p "$HOME/bin"
mkdir -p "$HOME/src"

# =====================================================================
# Symlink config files using GNU stow
# =====================================================================

print_success "\n========================================================================"
print_success "> Symlink config files using GNU stow"
print_success "========================================================================\n"

stow --restow common

# Print instruction for user to backup and remove conflicting GNU stow files
if [ $? -ne 0 ]; then
	print_error "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	print_error "! Please backup and remove above mentioned conflicting files and run this setup again"
	print_error "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -\n"
fi

case "$(current_os)" in
linux)
	print_success "\n========================================================================"
	print_success "> Symlink Linux config files using GNU stow"
	print_success "========================================================================\n"
	stow --restow linux
	;;
macos)
	print_success "\n========================================================================"
	print_success "> Symlink MacOS config files using GNU stow"
	print_success "========================================================================\n"
	stow --restow macos
	;;
esac

# Print instruction for user to backup and remove conflicting GNU stow files
if [ $? -ne 0 ]; then
	print_error "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	print_error "! Please backup and remove above mentioned conflicting files and run this setup again"
	print_error "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -\n"
fi

# =====================================================================
# Copy *.local files to appropriate locations
# =====================================================================

print_success "\n========================================================================"
print_success "> Copy *.local files to appropriate locations"
print_success "========================================================================\n"

if [ ! -e "$HOME/.bash.local" ]; then
	cp "local/.bash.local" "$HOME/.bash.local"
fi

if [ ! -e "$HOME/.config/git/config.local" ]; then
	cp "local/.gitconfig.local" "$HOME/.config/git/config.local"
fi

if [ ! -e "$HOME/.ssh/config.local" ]; then
	cp "local/ssh_config.local" "$HOME/.ssh/config.local"
fi

# =====================================================================
# Harden necessary locations
# =====================================================================

print_success "\n========================================================================"
print_success "> Harden necessary locations"
print_success "========================================================================\n"

harden "$HOME/.gnupg"
harden "$HOME/.local/state/gnupg"
harden "$HOME/.ssh"

# =====================================================================
# Print next instructions for the user
# =====================================================================

print_success "\n========================================================================"
print_success "> Print next instructions for the user"
print_success "========================================================================\n"

# Manually install named tools using OS' native software manager

if ! cmd_exists "alacritty"; then
	print_warning "- Install Alacritty using native OS software manager"
fi

if ! cmd_exists "subl"; then
	print_warning "- Install Sublime Text using native OS software manager"
fi

if ! [ -d "$HOME/.password-store" ]; then
	print_warning "- Initialize pass repo in ~/.password-store"
fi

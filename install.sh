#!/bin/sh

DOTFILES=$(pwd)

OS=$(uname -s)
# Linux = Linux
# Darwin = macOS

ARCH=$(uname -m)
# x86_64 = 64-bit
# arm64 = ARM

echo "Setting up your machine - $OS $ARCH"

# Grab path for Homebrew
if [ 'Linux' = "$OS" ]; then
  HOMEBREW_PATH=/home/linuxbrew/.linuxbrew/bin/brew
elif [ 'Darwin' = "$OS" ] && [ 'x86_64' = ARCH ]; then
  HOMEBREW_PATH=/usr/local/bin/brew
elif [ 'Darwin' = "$OS" ] && [ 'arm64' = ARCH ]; then
  HOMEBREW_PATH=/opt/homebrew/bin/brew
else
  echo "Unsupported OS/Arch combination"
  exit 1
fi

# Check if git is installed
if test ! "$(which git)"; then
  echo "Please install git"
  exit 1
fi

# Check if zsh is installed
if test ! "$(which zsh)"; then
  echo "Please install zsh"
  exit 1
fi

# Check for Oh My Zsh and install if we don't have it
if test ! "$(which omz)"; then
  echo "Installing Oh My Zsh"
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install powerlevel10k
if test ! "$(which p10k)"; then
  echo "Installing powerlevel10k theme"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k
fi

# Install zsh plugins
if test ! -d "$HOME"/.oh-my-zsh/custom/plugins/zsh-autosuggestions; then
  echo "Installing zsh-autosuggestions"
  git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
fi

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the dotfiles
echo "Creating symlink to .zshrc"
rm -rf "$HOME"/.zshrc
ln -s "$DOTFILES"/shell/.zshrc "$HOME"/.zshrc

echo "Creating symlink to .p10k.zsh"
rm -rf "$HOME"/.p10k.zsh
ln -s "$DOTFILES"/shell/.p10k.zsh "$HOME"/.p10k.zsh

# Configure git
echo "Configuring git"
echo "Creating ~/.gitconfig.local"
touch "$HOME"/.gitconfig.local

echo "Creating symlink to .gitconfig"
rm -rf "$HOME"/.gitconfig
ln -s "$DOTFILES"/git/.gitconfig "$HOME"/.gitconfig

echo "Creating symlink to .gitignore_global"
rm -rf "$HOME"/.gitignore
ln -s "$DOTFILES"/git/.gitignore "$HOME"/.gitignore

echo "Creating symlink to .gitattributes"
rm -rf "$HOME"/.gitattributes
ln -s "$DOTFILES"/git/.gitattributes "$HOME"/.gitattributes

# Check if it's a codespace
if test ! "$CODESPACES"; then
  exit 0
fi

# Check for Homebrew and install if we don't have it
if test ! "$(which brew)"; then
  echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$('"$HOMEBREW_PATH"' shellenv)"' >>"$HOME"/.zprofile
  eval "$("$HOMEBREW_PATH" shellenv)"
fi

# Update Homebrew recipes
echo "Update brew repositories"
brew update

# Install all our dependencies with bundle (See Brewfile)
echo "Install brew bundle"
brew tap homebrew/bundle

# General brew bundle
brew bundle --file "$DOTFILES"/brew/brewfile

# macOS specific installation
if [ 'Darwin' = "$OS" ]; then
  # macOS specific brew bundle
  brew bundle --file "$DOTFILES"/brew/osx.Brewfile

  # Symlink the Mackup config file to the home directory
  echo "Creating symlink to Mackup config file"
  ln -s "$DOTFILES"/.mackup.cfg "$HOME"/.mackup.cfg

  # Set macOS preferences - we will run this last because this will reload the shell
  echo "Setting macOS preferences"
  source "$DOTFILES"/shell/.macos
fi

# Linux specific installation
if [ 'Linux' = "$OS" ]; then
  # install dotnet
  echo "Installing dotnet"
  wget https://packages.microsoft.com/config/ubuntu/21.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
  sudo dpkg -i packages-microsoft-prod.deb
  rm packages-microsoft-prod.deb

  sudo apt-get update
  sudo apt-get install -y apt-transport-https &&
    sudo apt-get update &&
    sudo apt-get install -y dotnet-sdk-6.0
fi

## Enable local HTTPS for .NET Core
if test "$(which dotnet)"; then
  echo "Enabling local HTTPS for .NET Core"
  dotnet dev-certs https --trust
fi

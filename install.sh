#!/bin/sh

OS=$(uname -s)
# Linux = Linux
# Darwin = macOS

ARCH=$(uname -m)
# x86_64 = 64-bit
# arm64 = ARM

echo "Setting up your machine - $OS $ARCH"

# Check if git is installed
if test ! $(which git); then
    echo "Please install git"
    exit 1
fi

# Check if zsh is installed
if test ! $(which zsh); then
    echo "Please install zsh"
    exit 1
fi

# Check for Oh My Zsh and install if we don't have it
if test ! $(which omz); then
    echo "Installing Oh My Zsh"
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

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

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
    echo "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    echo 'eval "$('$HOMEBREW_PATH' shellenv)"' >>$HOME/.zprofile
    eval "$($HOMEBREW_PATH shellenv)"
fi

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
echo "Creating symlink to .zshrc"
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/shell/.zshrc $HOME/.zshrc

# Update Homebrew recipes
echo "Update brew repositories"
brew update

# Install Oh My Posh
if test ! $(which oh-my-posh); then
    echo "Installing Oh My Posh"
    if [ 'Darwin' = "$OS" ]; then
        brew tap jandedobbeleer/oh-my-posh
        brew install oh-my-posh
    elif [ 'Linux' = "$OS" ]; then
        sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
        sudo chmod +x /usr/local/bin/oh-my-posh
    fi

    echo 'eval "$(oh-my-posh --init --shell zsh --config '$DOTFILES'/shell/ohmyposh.json)"' >>$HOME/.zprofile
fi

# Install all our dependencies with bundle (See Brewfile)
echo "Install brew bundle"
brew tap homebrew/bundle

# General brew bundle
brew bundle --file $DOTFILES/Brewfile

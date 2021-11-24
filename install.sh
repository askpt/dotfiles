#!/bin/sh

OS=$(uname -s)
ARCH=$(uname -m)

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

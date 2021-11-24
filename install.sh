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

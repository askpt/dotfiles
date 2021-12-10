#!/usr/bin/env bash

BIN_NAME=$(basename "$0")
COMMAND_NAME=$1
SUB_COMMAND_NAME=$2

OS=$(uname -s)
# Linux = Linux
# Darwin = macOS

if [ 'Linux' = "$OS" ]; then
  HOMEBREW_PATH=/home/linuxbrew/.linuxbrew/bin/brew
elif [ 'Darwin' = "$OS" ] && [ 'x86_64' = ARCH ]; then
  HOMEBREW_PATH=/usr/local/bin/brew
elif [ 'Darwin' = "$OS" ] && [ 'arm64' = ARCH ]; then
  HOMEBREW_PATH=/opt/homebrew/bin/brew
fi

sub_help() {
  echo "Usage: $BIN_NAME <command>"
  echo
  echo "Commands:"
  echo "   clean            Clean up caches (brew)"
  # echo "   dock             Apply macOS Dock settings"
  # echo "   edit             Open dotfiles in IDE ($DOTFILES_IDE) and Git GUI ($DOTFILES_GIT_GUI)"
  echo "   help             This help message"
  # echo "   macos            Apply macOS system defaults"
  echo "   update           Update packages and pkg managers (OS, brew, npm)"
}

# sub_edit() {
#   sh -c "$DOTFILES_IDE $DOTFILES_DIR"
#   sh -c "$DOTFILES_GIT_GUI $DOTFILES_DIR"
# }

sub_update() {
  sudo softwareupdate -i -a
  brew update
  brew upgrade
  brew cleanup
  # npm install npm -g
  # npm update -g
}

sub_clean() {
  if test ! -d "$HOMEBREW_PATH"; then
  else
    brew cleanup
  fi
}

# sub_macos() {
#   for DEFAULTS_FILE in "${DOTFILES_DIR}"/macos/defaults*.sh; do
#     echo "Applying ${DEFAULTS_FILE}" && . "${DEFAULTS_FILE}"
#   done
#   echo "Done. Some changes may require a logout/restart to take effect."
# }

# sub_dock() {
#   . "${DOTFILES_DIR}/macos/dock.sh" && echo "Dock reloaded."
# }

case $COMMAND_NAME in
"" | "-h" | "--help")
  sub_help
  ;;
*)
  shift
  sub_${COMMAND_NAME} $@
  if [ $? = 127 ]; then
    echo "'$COMMAND_NAME' is not a known command or has errors." >&2
    sub_help
    exit 1
  fi
  ;;
esac

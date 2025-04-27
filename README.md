# dotfiles

## What is?

dotfiles are a group of special files that store some important user settings like terminal options and plugins. Using this installation I can easily roam my settings across multiple machines, including macOS, Linux, WLS2 and GitHub Codespaces.
This is possible due to [chezmoi](https://www.chezmoi.io).
There are some settings that are specific for me, so use this repository as a guide.

## Prerequisites

- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) must be installed.
- You must be logged in to Azure CLI using `az login` for all features to work correctly.

## Installation

Run this script in the terminal:
`sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply askpt`

## GitHub Copilot CLI Setup

To use GitHub Copilot CLI, follow these steps:

1. Make sure you have the [GitHub CLI](https://cli.github.com/) installed.
2. Log in to your GitHub account using the CLI:
   ```sh
   gh auth login
   ```
3. Install the Copilot CLI extension:
   ```sh
   gh extension install github/gh-copilot
   ```

## GPG Key Import

A GPG private key template is provided at `home/private_dot_gnupg/key.asc.tmpl`. After setup, your GPG key will be available at `~/.gnupg/key.asc` on your system. To import this key into your GPG keyring, run:

```sh
gpg --import ~/.gnupg/key.asc
```

After importing, for security, you should remove the key file:

```sh
rm ~/.gnupg/key.asc
```

Keep your private key secure and never share it publicly.

## Thanks To

I want to thank all the people that worked on the following repositories:

- [chezmoi](https://github.com/twpayne/chezmoi)
- [twpayne/dotfiles](https://github.com/twpayne/dotfiles)
- [driesvints/dotfiles](https://github.com/driesvints/dotfiles)
- [webpro/awesome-dotfiles](https://github.com/webpro/awesome-dotfiles)

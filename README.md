# dotfiles

## What is?

dotfiles are a group of special files that store important user settings, such as terminal options and plugins. Using this installation, I can easily roam my settings across multiple machines, including macOS, Linux, WLS2, and GitHub Codespaces.
This is possible due to [chezmoi](https://www.chezmoi.io).
There are some settings that are specific to me, so use this repository as a guide.

## Prerequisites

- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) must be installed.
- You must be logged in to Azure CLI using `az login` for all features to work correctly.

## Installation

Run this script in the terminal:

```sh
sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply askpt
```

## Work vs personal machine

Chezmoi now detects a work machine using a marker file in your home directory:

- If `~/.work` exists, the machine is treated as **work**.
- If `~/.work` does not exist, the machine is treated as **personal**.

To mark a machine as work:

```sh
touch ~/.work
```

To switch back to personal:

```sh
rm ~/.work
```

## Thanks To

I want to thank all the people that worked on the following repositories:

- [chezmoi](https://github.com/twpayne/chezmoi)
- [twpayne/dotfiles](https://github.com/twpayne/dotfiles)
- [driesvints/dotfiles](https://github.com/driesvints/dotfiles)
- [webpro/awesome-dotfiles](https://github.com/webpro/awesome-dotfiles)

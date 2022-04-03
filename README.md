# dotfiles

## What is?

dotfiles are a group of special files that store some important user settings like terminal options and plugins. Using this installation I can easily roam my settings across multiple machines, including macOS, Linux, WLS2 and GitHub Codespaces.
This is possible due to [chezmoi](https://www.chezmoi.io).
There are some settings that are specific for me, so use this repository as a guide.

## Installation

Run this script in the terminal:
`sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply askpt`

## Thanks To

I want to thank all the people that worked on the following repositories:

- [chezmoi](https://github.com/twpayne/chezmoi)
- [twpayne/dotfiles](https://github.com/twpayne/dotfiles)
- [driesvints/dotfiles](https://github.com/driesvints/dotfiles)
- [webpro/awesome-dotfiles](https://github.com/webpro/awesome-dotfiles)

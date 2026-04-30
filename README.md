# configs

Terminal and editor configs, themes, and an install script for getting a new Mac set up.

## What's in here

| File / dir | Purpose |
|---|---|
| `setup.sh` | `brew install` script for all CLI tools — run on a new machine |
| `ghostty/config` | Ghostty terminal config (colors, font, keybindings) |
| `terminal-cheatsheet.md` | Keybindings and tool reference for the CLI setup |
| `iterm.itermcolors` | iTerm2 color scheme |
| `sublime_theme` | Sublime Text color theme (.tmTheme) |
| `cursor_theme.jsonc` / `leah-theme.json` / `leah_theme/` | Cursor editor themes |
| `darkreader_configs` | Dark Reader browser extension settings |
| `bash_profile` | Old bash config (kept for reference) |
| `.gitconfig` | git config including delta diff settings |
| `.git-completion.bash` | git tab-completion for bash |

## On a new machine

1. Install [Homebrew](https://brew.sh)
2. Clone this repo
3. Run `./setup.sh`
4. Follow the manual steps printed at the end (copy configs into place)

## Cheatsheet

See [`terminal-cheatsheet.md`](terminal-cheatsheet.md) — covers shell keybindings, fzf, zoxide, modern CLI tools (rg / bat / eza / fd / jq), tldr, git delta, Ghostty shortcuts, and zsh tips.

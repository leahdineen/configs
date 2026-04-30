#!/bin/bash
# Install script for tools and configs in this repo.
# Run on a new machine after installing Homebrew.
set -e

##### Sublime Text symlink #####################################################
if [[ -e "/Applications/Sublime Text.app" && ! -e /usr/local/bin/subl ]]; then
  ln -sv "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
fi

##### Terminal emulator ########################################################
brew install --cask ghostty

##### Core CLI tools ###########################################################
# Search / find / view
brew install ripgrep        # rg — fast grep, respects .gitignore
brew install fd             # fd — saner find
brew install bat            # cat with syntax highlighting
brew install eza            # modern ls (git status, tree, colors)
brew install jq             # JSON processor

# Productivity
brew install fzf            # fuzzy finder — Ctrl+R, Ctrl+T, Alt+C
brew install zoxide         # smart cd — `z partial-name`
brew install tldr           # example-based command help
brew install starship       # cross-shell prompt (optional, see notes)

# Git
brew install git-delta      # pretty git diffs

# Shell extras
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting

# Misc (kept from earlier setup)
brew install ack
brew install bash-completion
brew install thefuck
brew install pre-commit

##### Manual config steps (do these by hand) ###################################
cat <<'EOF'

──────────────────────────────────────────────────────────────────────────────
  Binaries are installed. Now copy configs into place:

    Ghostty:    cp ghostty/config ~/.config/ghostty/config
                (create the dir first if needed: mkdir -p ~/.config/ghostty)

    Sublime:    copy sublime_theme into Sublime's Packages/Themes dir
                (Preferences → Browse Packages…)

    Cursor:     import leah-theme.json or use the .vsix in leah_theme/

    iTerm2:     import iterm.itermcolors via Preferences → Profiles → Colors

    Zsh:        append the "Power-user CLI tools" block to ~/.zshrc
                (see terminal-cheatsheet.md for what it contains)

    Git:        merge .gitconfig contents into ~/.gitconfig
                (delta config is in there)

  Cheatsheet:   terminal-cheatsheet.md  — keybindings + tool usage
──────────────────────────────────────────────────────────────────────────────

EOF

# Terminal Power-User Cheatsheet

## Shell keybindings (readline — built into zsh, no setup)

### Cursor movement
| Key | Action |
|---|---|
| `Ctrl+A` | Jump to start of line |
| `Ctrl+E` | Jump to end of line |
| `Option+Left` | Back one word *(left Option only)* |
| `Option+Right` | Forward one word |

### Editing
| Key | Action |
|---|---|
| `Ctrl+W` | Delete word backward |
| `Option+D` | Delete word forward |
| `Ctrl+U` | Delete from cursor to start of line |
| `Ctrl+K` | Delete from cursor to end of line |
| `Ctrl+Y` | Paste back what you just killed |
| `Ctrl+T` | Swap two characters around cursor |

### Process control
| Key | Action |
|---|---|
| `Ctrl+C` | Cancel current command |
| `Ctrl+D` | EOF (logout when at empty prompt) |
| `Ctrl+Z` | Suspend foreground process |
| `fg` | Resume suspended process |
| `bg` | Resume in background |
| `jobs` | List suspended/background jobs |

### Misc
| Key | Action |
|---|---|
| `Ctrl+L` | Clear screen (better than `clear` — faster) |
| `Ctrl+R` | Search command history (fzf-powered now) |
| `Option+.` | Insert last argument of previous command |

---

## History magic (type these literally)

| Syntax | Meaning |
|---|---|
| `!!` | Last command (e.g. `sudo !!`) |
| `!$` | Last argument of last command |
| `!*` | All arguments of last command |
| `!abc` | Last command starting with "abc" |
| `^old^new` | Re-run last command with `old` replaced by `new` |
| `cd -` | Go to previous directory |

---

## fzf (fuzzy finder)

| Key / Command | What it does |
|---|---|
| `Ctrl+R` | Fuzzy-search command history (replace your old one) |
| `Ctrl+T` | Fuzzy-pick a file → inserts path into current command |
| `Option+C` | Fuzzy-pick a directory → `cd` into it |
| `kill -9 <Tab>` | Tab completes processes via fzf |
| `ssh <Tab>` | Tab completes hostnames via fzf |

Inside fzf: type to filter, `Ctrl+J/K` to move, `Enter` to select, `Esc` to cancel.

---

## zoxide (smart cd)

| Command | What it does |
|---|---|
| `z foo` | Jump to most-recent dir matching "foo" |
| `z foo bar` | Jump to dir matching both "foo" and "bar" |
| `zi foo` | Interactive picker if multiple matches |
| `z -` | Previous directory |

zoxide learns from your `cd` usage. Use it for a few days before judging it.

---

## Modern CLI tools

| Old | New | Notes |
|---|---|---|
| `cat file` | `bat file` | Syntax highlighting, line numbers, paging |
| `grep -r foo .` | `rg foo` | Way faster, respects `.gitignore` by default |
| `find . -name '*.py'` | `fd '\.py$'` | Saner syntax |
| `ls -la` | `la` (aliased to eza) | Git status column, colors, icons |
| `ls --tree` | `lt` | Tree view, 2 levels deep |
| `du -sh *` | `dust` | Tree-style disk usage *(not installed, brew install dust)* |
| `top` / `htop` | `btop` | Prettier process viewer *(brew install btop)* |

### Useful one-liners
```sh
# Pretty-print + page JSON
curl -s api.example.com/data | jq | bat -l json

# Find recent files
fd -t f --changed-within 1d

# Search inside files (rg = ripgrep)
rg "TODO" --type py

# JSON: extract a field
cat data.json | jq '.users[].email'
```

---

## Ghostty keybindings

| Key | Action |
|---|---|
| `Cmd+T` | New tab |
| `Cmd+N` | New window |
| `Cmd+W` | Close tab/window |
| `Cmd+D` | Split right |
| `Cmd+Shift+D` | Split down |
| `Cmd+W` | Close current split (or tab/window if no split) |
| `exit` (typed) | Also closes the current split — universal |
| `Cmd+Option+Arrow` | Move between splits |
| `Cmd+[` / `Cmd+]` | Previous/next tab |
| `Cmd+1`...`Cmd+9` | Jump to tab N |
| `Cmd+K` | Clear scrollback |
| `Cmd++` / `Cmd+-` | Zoom in/out |
| `Cmd+,` | Open config in editor |
| `Cmd+Shift+,` | Reload config |

Ported from iTerm2:
- `Shift+Return` → newline (no submit)
- `Option+Left/Right` → word jump

---

## tldr — example-based command help

Faster than `man` when you just need usage examples.

| Command | What it does |
|---|---|
| `tldr <cmd>` | Show common examples for a command |
| `tldr tar` | e.g. `tar -xzf archive.tar.gz` without reading 200 lines |
| `tldr --update` | Refresh the local example cache |
| `tldr -p osx <cmd>` | Show macOS-specific examples |

Great targets: `tldr tar`, `tldr ssh`, `tldr ffmpeg`, `tldr find`, `tldr curl`, `tldr rsync`, `tldr awk`.

---

## git delta — pretty diffs

Already wired into `~/.gitconfig`. Every diff command now uses delta automatically.

| Command | What you get |
|---|---|
| `git diff` | Side-by-side colored diff with line numbers |
| `git show HEAD` | Same treatment for any commit |
| `git log -p` | Patch view with delta formatting |
| `git stash show -p` | Pretty stash diffs too |

Inside the delta pager:
| Key | Action |
|---|---|
| `n` / `N` | Jump to next / previous diff section |
| `Space` / `b` | Page down / up (it's `less` under the hood) |
| `/foo` | Search for "foo" |
| `q` | Quit |

Tweaks (run as `git config --global ...`):
- `delta.side-by-side false` — switch to unified diff if side-by-side feels cramped
- `delta.line-numbers false` — hide line numbers
- `delta.syntax-theme "GitHub"` — different syntax theme (`delta --show-syntax-themes` to browse)

---

## zsh tips

```sh
# Globs
ls **/*.py          # recursive — finds all .py files at any depth
ls *(.)             # only regular files
ls *(/)             # only directories
ls -t *(om)         # sorted by modified time

# Brace expansion
mv file.{txt,bak}   # = mv file.txt file.bak
mkdir -p src/{api,web,shared}

# Command substitution
echo "Today: $(date +%Y-%m-%d)"
```

---

## Things to learn next

1. **starship** — installed, not enabled. Try with `eval "$(starship init zsh)"` in a single shell to preview
2. **A real $EDITOR** — set `export EDITOR=vim` (or `code -w`, `subl -w`) so git/CLI tools open your editor
3. **direnv** — auto-load `.envrc` per project. Best way to kill the API-keys-in-zshrc problem
4. **macOS Keychain for global secrets** — `security add-generic-password` to store, `security find-generic-password -w` to read in `.zshrc`. No more plaintext keys on disk.

---

## What I changed for you

- `~/.config/ghostty/config` — colors, keybindings, font
- `~/.zshrc` — appended a "Power-user CLI tools" block at the very bottom
- Installed via Homebrew: `fzf`, `zoxide`, `bat`, `eza`, `starship`
- Already had: `ripgrep`, `fd`, `jq`

To activate everything: open a new Ghostty window or run `source ~/.zshrc`.

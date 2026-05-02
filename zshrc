# Added by ForgeCode installer
export PATH="/Users/leahdineen/.local/bin:$PATH"
##### Core env & Homebrew ######################################################
# Use Apple Silicon Homebrew if present
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set Python 3.11 as default
export PATH="/opt/homebrew/opt/python@3.11/libexec/bin:$PATH"

# Colors & terminal
export CLICOLOR=1
export TERM="xterm-256color"
export LSCOLORS="GxFxCxDxBxegedabagaced"

# Java (Android Studio)
export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"

##### Tab title: "<command> — <cwd>" (iTerm2-style) ###########################
# At the prompt, show "zsh — ~/path".
# While a command runs, show "<cmd> — ~/path".
precmd() {
  print -Pn "\e]0;zsh — %~\a"
}

preexec() {
  # ${1%% *} = first word of the command line (the program name)
  print -Pn "\e]0;${1%% *} — %~\a"
}

# Force prompt refresh when changing directories
chpwd() {
  # This ensures git branch info updates when you cd into/out of git repos
  true
}

##### Completion ###############################################################
autoload -Uz compinit
compinit -C

# Load git completion if you have it (optional)
[[ -f "${HOME}/.git-completion.zsh" ]] && source "${HOME}/.git-completion.zsh"

##### Aliases ##################################################################
alias ls='ls -GFh'
alias la='ls -aGFh'
alias pc='pre-commit run --all-files'
# alias pip='pip3'  # Commented out - can cause externally-managed-environment errors
alias python='python3'

##### Functions ################################################################
prettyjson() {
  echo "$1" | python -m json.tool
}

venvup() {
  local name="${1:-.venv}"
  python -m venv "$name" && source "$name/bin/activate"
}

# Disable sleep for N hours (default 2), even with lid closed
nosleep() {
  local hours="${1:-2}"
  sudo pmset -a disablesleep 1
  echo "Sleep disabled for $hours hour(s)."
  (sleep $((hours * 3600)) && sudo pmset -a disablesleep 0 && echo "Sleep re-enabled.") &!
}

alias yessleep='sudo pmset -a disablesleep 0 && echo "Sleep re-enabled."'


##### Prompt (zsh-native) ######################################################
# Enable prompt substitution BEFORE defining functions
setopt PROMPT_SUBST

# Colors
local RED='%F{red}' PURPLE='%F{magenta}' GREEN='%F{green}' CYAN='%F{cyan}' RESET='%f'

# Function: show git branch with uncommitted/unpushed counts
git_branch() {
  if command git rev-parse --git-dir >/dev/null 2>&1; then
    local branch git_info
    branch=$(command git symbolic-ref --short HEAD 2>/dev/null || command git rev-parse --short HEAD 2>/dev/null)
    [[ -z "$branch" ]] && return

    git_info="$branch"

    # Count uncommitted files (staged + unstaged + untracked)
    local uncommitted
    uncommitted=$(command git status --porcelain 2>/dev/null | wc -l | tr -d ' ')
    (( uncommitted > 0 )) && git_info="$git_info ${uncommitted}∆"

    # Count commits ahead of upstream (unpushed)
    local unpushed
    unpushed=$(command git rev-list --count @{upstream}..HEAD 2>/dev/null || echo "0")
    (( unpushed > 0 )) && git_info="$git_info ${unpushed}↑"

    print "[${git_info}]"
  fi
}

export VIRTUAL_ENV_DISABLE_PROMPT=1

# Function: show Python venv name if active
python_venv() {
  [[ -n "$VIRTUAL_ENV" ]] && print "[${VIRTUAL_ENV:t}] "
}

# Prompt: HH:MM [venv] @cwd [branch 2∆ 1↑] $
PROMPT='${RED}%T ${CYAN}$(python_venv)'"${RED}@${PURPLE}%~${RESET}"' ${GREEN}$(git_branch)${RESET} %# '

# Secondary prompt for multiline input
PROMPT2=' | → '

##### Plugins (Homebrew) #######################################################
# Use brew --prefix to be robust to path changes
if command -v brew >/dev/null 2>&1; then
  # Autosuggestions
  if [[ -r "$(brew --prefix zsh-autosuggestions)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
    source "$(brew --prefix zsh-autosuggestions)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  fi

  # (Keep syntax highlighting LAST)
  if [[ -r "$(brew --prefix zsh-syntax-highlighting)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source "$(brew --prefix zsh-syntax-highlighting)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  fi
fi


##### API keys #################################################################
# DO NOT paste real key values here — this file is checked in to git.
# Better patterns:
#   1. macOS Keychain:
#        security add-generic-password -a "$USER" -s OPENAI_API_KEY -w 'sk-...'
#        export OPENAI_API_KEY="$(security find-generic-password -a "$USER" -s OPENAI_API_KEY -w)"
#   2. direnv per-project:
#        ~/dev/.envrc      → shared keys
#        ~/dev/proj/.envrc → `source_up` + project-specific overrides
export PYTHONPATH=.
# export OPENAI_API_KEY="REPLACE_ME"
# export GOOGLE_API_KEY="REPLACE_ME"
# export GEMINI_API_KEY="REPLACE_ME"
# export BLOB_READ_WRITE_TOKEN="REPLACE_ME"
# export JUDGE_DEV_API_KEY="REPLACE_ME"
# export JUDGE_SANDBOX_API_KEY="REPLACE_ME"
# export JUDGE_PROD_API_KEY="REPLACE_ME"
# export OVERSHOOT_API_KEY="REPLACE_ME"

eval $(thefuck --alias)
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

. "$HOME/.local/bin/env"
alias tf="terraform"

##### Power-user CLI tools #####################################################
# fzf: Ctrl+R fuzzy history, Ctrl+T fuzzy file picker, Alt+C fuzzy cd
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi

# zoxide: smart cd — `z partial-name` to jump to recent dirs
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# eza: modern ls replacement (overrides earlier ls/la aliases)
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --group-directories-first'
  alias ll='eza -l --git --group-directories-first'
  alias la='eza -la --git --group-directories-first'
  alias lt='eza --tree --level=2 --group-directories-first'
fi

# starship prompt — installed but not enabled.
# To try it: run `eval "$(starship init zsh)"` in a single shell.
# To switch permanently: comment out the PROMPT= block above and uncomment below.
# eval "$(starship init zsh)"

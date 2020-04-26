[[ -s ~/.bashrc ]] && source ~/.bashrc

if [ $ITERM_SESSION_ID ]; then
  export PROMPT_COMMAND='echo -ne "\033];${PWD##*/}\007"; ':"$PROMPT_COMMAND";
fi

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

export CLICOLOR=1
export TERM='xterm-256color'
export LSCOLORS=GxFxCxDxBxegedabagaced

alias ls='ls -GFh'
alias la='ls -aGFh'

alias pc='pre-commit run --all-files'

prettyjson() {
    echo "$1" | python -m json.tool
}


function prompt {
  local BLACK="\[\033[0;30m\]"
  local BLACKBOLD="\[\033[1;30m\]"
  local RED="\[\033[0;31m\]"
  local REDBOLD="\[\033[1;31m\]"
  local GREEN="\[\033[0;32m\]"
  local GREENBOLD="\[\033[1;32m\]"
  local YELLOW="\[\033[0;33m\]"
  local YELLOWBOLD="\[\033[1;33m\]"
  local BLUE="\[\033[0;34m\]"
  local BLUEBOLD="\[\033[1;34m\]"
  local PURPLE="\[\033[0;35m\]"
  local PURPLEBOLD="\[\033[1;35m\]"
  local CYAN="\[\033[0;36m\]"
  local CYANBOLD="\[\033[1;36m\]"
  local WHITE="\[\033[0;37m\]"
  local WHITEBOLD="\[\033[1;37m\]"
  local RESETCOLOR="\[\e[00m\]"

  if test -z "$VIRTUAL_ENV" ; then
      PYTHON_VIRTUALENV=""
  else
      PYTHON_VIRTUALENV="${CYAN}[`basename \"$VIRTUAL_ENV\"`]${COLOR_NONE} "
  fi

  export PS1="${PYTHON_VIRTUALENV}$RED\u$RED@$PURPLE\w$RESETCOLOR$GREENBOLD\$(git branch 2> /dev/null | cut -f2 -d\* -s | sed 's/^ / [/' | sed 's/$/]/' )$RESETCOLOR \$ "
  export PS2=" | → $RESETCOLOR"
}

PROMPT_COMMAND=prompt


test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -l'
# PS1='[\u@\h \W]\$ '

build_prompt() {
  # color
  EXIT=$?
  CYAN='\[\e[0;36m\]'
  LBL='\[\e[38;2;173;216;230m\]'
  OG='\[\e[38;5;208m\]'
  LPP='\[\e[1;35m\]'
  GR='\[\e[0;32m\]'
  RD='\[\e[0;31m\]'
  WH1='\[\e[0;97m\]'
  WH2='\[\e[1;97m\]'
  NO='\[\e[0m\]'
  BLUE='\[\e[38;2;23;147;209m\]'
  ARCHBLUE='\[\e[38;5;39m\]'

  VENV_PROMPT=""
  if [ -n "$VIRTUAL_ENV" ]; then
    # mengambil nama folder venv dari path lengkapnya
    VENV_PROMPT="$OG($(basename "$VIRTUAL_ENV")) $NO"
  fi

  # Tentukan simbol berdasarkan User ID
  # UID 0 adalah root
  if [ "$EUID" -eq 0 ]; then
    SYMBOL="#"
    SHELL_COLOR=$RD
    HOST_COLOR=$RD
    PWD_COLOR=$RD
  else
    SYMBOL="$"
    SHELL_COLOR=$GR
    HOST_COLOR=$ARCHBLUE
    PWD_COLOR=$ARCHBLUE
  fi

  PS1="╭ $VENV_PROMPT$WH1[\A] $HOST_COLOR\h$WH2 \u $LBL🗁  $PWD_COLOR\w $NO\n"

  if [ $EXIT != 0 ]; then
    PS1+="╰ $RD✘ $EXIT"
  else
    # Menggunakan variabel SYMBOL yang dinamis
    PS1+="╰ $SHELL_COLOR$SYMBOL"
  fi
  PS1+=" $NO"
  export PS1
}

export VIRTUAL_ENV_DISABLE_PROMPT=1
PROMPT_COMMAND=build_prompt

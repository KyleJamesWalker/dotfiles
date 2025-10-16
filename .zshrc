# Add path for personal bin and global tools virtual environment
export PATH=$HOME/bin:$HOME/.uv/genv/.venv/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="risto"

plugins=(
  git
  python
  brew
  vi-mode
  postgres
  history
  history-substring-search
  docker
)

source $ZSH/oh-my-zsh.sh

# User configuration
export EDITOR=vim
export GPG_TTY=$(tty)

eval "$(thefuck --alias f)"

# Load personal credentials if the file exists
[[ -f $HOME/.zshrc-creds ]] && source /Users/kyle.walker/.zshrc-creds

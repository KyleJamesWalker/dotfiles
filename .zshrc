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
source ~/.zshrc-creds

eval "$(thefuck --alias f)"

export GPG_TTY=$(tty)

export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/kyle.walker/.oh-my-zsh"

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
  pyenv
)

source $ZSH/oh-my-zsh.sh

# User configuration
export EDITOR=vim
source ~/.zshrc-creds

eval "$(thefuck --alias f)"

if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

export GPG_TTY=$(tty)

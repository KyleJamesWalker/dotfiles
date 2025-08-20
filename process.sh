#!/bin/bash

# Install XCode
if ! xcode-select -p > /dev/null ; then
	echo Installing XCode Command Line Tools
	xcode-select --install
	read -p "Press enter to continue when Xcode has finished installing"
else
	echo XCode Command Line Tools Already installed
fi

# Install brew
if ! which brew > /dev/null ; then
  echo Installing HomeBrew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/$USER/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo Homebrew Already installed
fi

# Install some base tools
brew doctor
brew update
brew install wget vim python thefuck git jq tmux asciinema tree jfrog-cli npm aws-okta docker docker-compose colima zsh
pip3 install --upgrade pip setup-tools wheel

# Set shell to zsh
chsh -s /usr/local/bin/zsh

# Install Oh My ZSH!
if [ ! -d ~/.oh-my-zsh ]; then
  echo Installing Oh My ZSH!
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  cp .zshrc ~
  cp .zshrc-creds ~
else
  echo Oh My ZSH! Already Installed
fi

if ! which uv > /dev/null ; then
  echo Installing pyenv
  brew install uv
  uv python install 3.10
  uv python install 3.11
  uv python install 3.12

  # Create global tools environment, and install a few helpers
  mkdir -p ~/.uv/genv
  cd ~/.uv/genv; uv init --python 3.12 --bare; cd -
  cd ~/.uv/genv; uv add httpie zauthz aws2-wrap black flake8 pre-commit; cd -
else
  echo uv Already Installed
fi

# Install vundle
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  cp .vimrc ~
fi

# Copy Configs
cp .gitconfig ~
cp .psqlrc ~
git config --global core.hooksPath ~/githooks
cp -r githooks ~/
# Copy small helper scripts
cp -r bin ~/

# Allow Key repeating in all apps
defaults write -g ApplePressAndHoldEnabled -bool false

brew tap homebrew/cask-versions
brew tap asicsdigital/strongdm

# Install some standard tools
brew install --cask iterm2 visual-studio-code beyond-compare caffeine droplr homebrew/cask-fonts/font-hack dbeaver-community strongdm

brew install swagger-codegen gradle pcre2

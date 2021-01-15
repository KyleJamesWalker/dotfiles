#!/bin/bash

# Install XCode
if ! xcode-select -p > /dev/null ; then
	echo Installing XCode Command Line Tools
	xcode-select --install
else
	echo XCode Command Line Tools Already installed
fi

# Install brew
if ! which brew > /dev/null ; then
	echo Installing HomeBrew
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
	echo Homebrew Already installed
fi

# Install some base tools
brew doctor
brew update
brew install wget vim python thefuck git jq tmux asciinema tree jfrog-cli-go terragrunt terraform npm aws-okta
pip3 install --upgrade pip setuptools wheel

# Install Oh My ZSH!
if [ ! -d ~/.oh-my-zsh ]; then
	echo Installing Oh My ZSH!
	sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
	cp .zshrc ~
	cp .zshrc-creds ~
else
	echo Oh My ZSH! Already Installed
fi

if ! which pyenv > /dev/null ; then
	echo Installing pyenv
	brew install pyenv pyenv-virtualenv
	pyenv install 2.7.9
	pyenv install 3.6.6
	pyenv install 3.7.0
	pyenv virtualenv 3.6.6 genv
	pyenv global genv
else
	echo pyenv Already Installed
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

# Removed: boostnote path-finder keybase caskroom/versions/java8
brew install --cask iterm2 visual-studio-code beyond-compare caffeine docker droplr homebrew/cask-fonts/font-hack dbeaver-community

brew install swagger-codegen gradle

# Install vscode extensions (get the list from the following commands)
# code --list-extensions | xargs -L 1 echo code --install-extension
code --install-extension alexcvzz.vscode-sqlite
code --install-extension bajdzis.vscode-database
code --install-extension donjayamanne.githistory
code --install-extension donjayamanne.jupyter
code --install-extension dracula-theme.theme-dracula
code --install-extension eamodio.gitlens
code --install-extension formulahendry.code-runner
code --install-extension GrapeCity.gc-excelviewer
code --install-extension HookyQR.beautify
code --install-extension jakeboone02.cypher-query-language
code --install-extension jithurjacob.nbpreviewer
code --install-extension lextudio.restructuredtext
code --install-extension magicstack.MagicPython
code --install-extension mauve.terraform
code --install-extension mikestead.dotenv
code --install-extension ms-mssql.mssql
code --install-extension ms-python.python
code --install-extension msjsdiag.debugger-for-chrome
code --install-extension PeterJausovec.vscode-docker
code --install-extension searKing.preview-vscode
code --install-extension Shan.code-settings-sync
code --install-extension shd101wyy.markdown-preview-enhanced
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension vscodevim.vim
code --install-extension waderyan.gitblame

if ! which kr > /dev/null ; then
	# Install and pair Krypton
	curl https://krypt.co/kr | sh
	kr pair
	kr github
	kr codesign
else
	echo pyenv Already Installed
fi

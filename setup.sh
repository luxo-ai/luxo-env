#!/bin/bash

brew update
brew install jq \
	httpie \
	nvm \
	python3 \
	gnupg


# yarn for javascript/typescript development
if ! command -v yarn >/dev/null 2>&1;
then 
	echo "installing yarn..."
	# npm available through nvm
	npm install --global yarn
fi 

# haskell development
if ! command -v stack >/dev/null 2>&1;
then
	echo "installing stack w ghc..."
	curl -sSL https://get.haskellstack.org/ | sh
fi

echo "Git setup..."
./git-setup.sh
echo "Vim setup..."
./vim-setup.sh
echo "Zsh setup..."
./zsh-setup.sh
echo "Adding local bin..."
./add-local-bin.sh
echo "Setting key repeat on hold instead of special char..."
defaults write -g ApplePressAndHoldEnabled -bool false

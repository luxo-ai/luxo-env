#!/bin/zsh

# clone sorin-ionescu/prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# create a new zsh configuration
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

cat << EOF >> "$HOME/.zpreztorc"
zstyle ':prezto:module:editor' key-bindings 'vi'
EOF

# NOTE: may need to add
# if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]];
# then
#    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
# fi
# to .zshrc (if already existed)

# add 'git' module for git branch support
# set zsh as default shell
chsh -s $(which zsh)
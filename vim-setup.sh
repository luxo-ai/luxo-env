#!/bin/bash

VIM_PLUGIN_MANAGER="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

if ! command -v vim >/dev/null 2>&1;
then 
    echo "installing vim..."
    brew install vim
fi 


if [[ ! -f "$HOME/.vim/autoload/plug.vim" ]];
then
    echo "adding vim plugin manager"
    curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs "$VIM_PLUGIN_MANAGER"
fi

echo "setting up vimrc and overwriting if exists"

cat << EOF > "$HOME/.vimrc"

call plug#begin('~/.vim/plugged')
Plug 'ayu-theme/ayu-vim'
call plug#end()

inoremap jj <ESC>
:set number
:set showmatch
:set autowrite
:syntax on
:set wrap

set termguicolors     " enable true colors support
let ayucolor="light"  " for light version of theme
let ayucolor="mirage" " for mirage version of theme
let ayucolor="dark"   " for dark version of theme
colorscheme ayu

set autochdir
filetype indent on
set smartindent
autocmd BufRead,BufWritePre *.sh normal gg=G
set backspace=indent,eol,start
EOF

# install plugins
vim +'PlugInstall --sync' +qa
#!/bin/bash
ln -s ~/.vim/init.vim ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc

# neovim
if [ ! -d  ~/.config ] ; then
    mkdir ~/.config
fi
if [ ! -h  ~/.config/nvim ] ; then
    ln -s ~/.vim ~/.config/nvim
fi

cd ~/.vim && git submodule update --init


#!/bin/bash
ln -s ~/.vim/init.vim ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc

# neovim
if [ ! -d  ~/.config ] ; then
    mkdir ~/.config
fi
ln -s ~/.vim ~/.config/nvim

cd ~/.vim && git submodule update --init


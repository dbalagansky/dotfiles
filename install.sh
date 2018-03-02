#!/bin/sh

for i in ".bashrc" \
         ".inputrc" \
         ".nethackrc" \
         ".profile" \
         ".pythonrc" \
         ".screenrc" \
         ".tmux.conf" \
         ".vimrc"
do
    ln -sv `pwd`/"$i" "${HOME}/$i"
done

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git ~/.pyenv/plugins/pyenv-virtualenvwrapper

[ ! `which brew` ] && \
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && \
    brew bundle

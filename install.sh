#!/bin/sh

for i in ".bashrc" \
         ".inputrc" \
         ".nethackrc" \
         ".profile" \
         ".pythonrc" \
         ".screenrc" \
         ".tmux.conf" \
         ".vimrc" \
         ".Xresources" \
         ".ctags"
do
    ln -sv `pwd`/"$i" "${HOME}/$i"
done

mkdir -p "${HOME}/.config/nvim"
ln -sv "`pwd`/init.vim" "${HOME}/.config/nvim/init.vim"

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git ~/.pyenv/plugins/pyenv-virtualenvwrapper

[ ! `which brew` ] && [ `uname -s` = 'Darwin' ] && \
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && \
    brew bundle

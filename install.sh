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
         ".ctags" \
         ".exrc"
do
    ln -sv `pwd`/"$i" "${HOME}/$i"
done

ln -sv "`pwd`/.profile" "${HOME}/.bash_profile"
ln -sv "`pwd`/.xinitrc" "${HOME}/.xsession"

mkdir -p "${HOME}/.config/nvim"
ln -sv "`pwd`/init.vim" "${HOME}/.config/nvim/init.vim"

mkdir -p "${HOME}/.dwm"
ln -sv "`pwd`/config.h" "${HOME}/.dwm/config.h"

mkdir -p "${HOME}/.vim/"
ln -sv "`pwd`/.vim/pack" "${HOME}/.vim/pack"

git clone https://github.com/pyenv/pyenv.git ~/.pyenv
git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git ~/.pyenv/plugins/pyenv-virtualenvwrapper

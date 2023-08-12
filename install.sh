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
         ".exrc" \
         ".irssi"
do
    ln -sv `pwd`/"$i" "${HOME}/$i"
done

ln -sv "`pwd`/.profile" "${HOME}/.bash_profile"
ln -sv "`pwd`/.xinitrc" "${HOME}/.xsession"

mkdir -p "${HOME}/.config/nvim"
ln -sv "`pwd`/init.vim" "${HOME}/.config/nvim/init.vim"

mkdir -p "${HOME}/.vim/"
ln -sv "`pwd`/.vim/pack" "${HOME}/.vim/pack"

mkdir -p "${HOME}/.config/qutebrowser"
ln -sv "`pwd`/.config/qutebrowser/config.py" "${HOME}/.config/qutebrowser/config.py"

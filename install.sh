#!/bin/sh

for i in ".bashrc" \
         ".inputrc" \
         ".profile" \
         ".pythonrc" \
         ".tmux.conf" \
         ".vimrc" \
         ".ctags" \
         ".irssi"
do
    ln -sfv `pwd`/"$i" "${HOME}/$i"
done

ln -sfv "`pwd`/.profile" "${HOME}/.bash_profile"
ln -sfv "`pwd`/.xinitrc" "${HOME}/.xsession"
ln -sfv "`pwd`/.xinitrc" "${HOME}/.xinitrc"

mkdir -p "${HOME}/.vim/"
ln -sfv "`pwd`/.vim/pack" "${HOME}/.vim/pack"

mkdir -p "${HOME}/.config/qutebrowser"
ln -sfv "`pwd`/.config/qutebrowser/config.py" "${HOME}/.config/qutebrowser/config.py"

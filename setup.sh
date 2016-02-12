#!/bin/zsh

# List of symlinks.
SYMLINK_LIST=( ".vimrc" ".gitconfig" ".zshrc" )

############################################################
# install zprezto
if [ ! -d $HOME/.zprezto ] ; then
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi

setopt EXTENDED_GLOB
for rcfile in $HOME/.zprezto/runcoms/^README.md(.N); do
  echo "update-symbolic-link: => $rcfile"
  ln -sf "$rcfile" "$HOME/.${rcfile:t}"
done

############################################################
# vim-neobundle

if [ ! -d $HOME/.vim ] ; then
    mkdir -p ~/.vim/bundle
    git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi

############################################################
# Get the path of this script, and move there.
BASE_DIR=$(cd $(dirname $0);pwd)
cd $BASE_DIR

# Symlinks.
for FILE in $SYMLINK_LIST; do
    ln -sf $BASE_DIR/$FILE ~/$FILE
done

if [ ! -d $HOME/bin ] ; then
    ln -s $BASE_DIR/$FILE ~/$FILE
fi


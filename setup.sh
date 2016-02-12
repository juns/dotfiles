#!/bin/zsh

# List of symlinks.
SYMLINK_LIST=( "bin" ".vimrc" ".gitconfig" ".zshrc" )


if [ ! -d $HOME/.zprezto ] ; then
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi

setopt EXTENDED_GLOB
for rcfile in $HOME/.zprezto/runcoms/^README.md(.N); do
  echo "update-symbolic-link: => $rcfile"
  ln -sf "$rcfile" "$HOME/.${rcfile:t}"
done

# Get the path of this script, and move there.
BASE_DIR=$(cd $(dirname $0);pwd)
cd $BASE_DIR

# Symlinks.
for FILE in $SYMLINK_LIST; do
    ln -sf $BASE_DIR/$FILE ~/$FILE
done


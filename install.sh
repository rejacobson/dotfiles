#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cd "$DIR"

FILES=(.bashrc .bash_profile .gemrc .gitconfig .inputrc .vim .vimrc)

for file in ${FILES[*]}
do
  dotfile="$HOME/dotfiles/$file"
  symlink="$HOME/$file"
  backup="$HOME/${file}_BAK"

  echo "--- $file"

  #    file exists        is NOT a symlink
  if [ -e $symlink ] && [ ! -h $symlink ]; then
    echo "$file exists; Moving to $backup"
    mv $symlink $backup
  fi

  if [ -e $dotfile ]; then
    echo "Creating sym link: $dotfile -> $symlink"
    ln -s $dotfile $symlink
  else
    echo "Dotfile does not exist: $dotfile"
  fi

  echo -e "\n"
done

#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cd "$DIR"

FILES=(.bashrc .bash_profile .config/cheat .gemrc .gitconfig .inputrc .mostrc .tmux.conf .vim .vimrc)

for file in ${FILES[*]}
do
  dotfile="$HOME/dotfiles/$file"
  symlink="$HOME/$file"
  backup="$HOME/${file}_BAK"

  echo "$file"

  if [ ! -h $symlink ]; then
    if [ -e $symlink ]; then
      echo "--- Moving $file to $backup"
      mv $symlink $backup
    fi

    if [ -e $dotfile ]; then
      echo "--- Creating sym link: $dotfile -> $symlink"
      ln -s $dotfile $symlink
    else
      echo "--- Dotfile does not exist: $dotfile"
    fi
  else
    echo "--- Already installed"
  fi

  echo -e "\n"
done

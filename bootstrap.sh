#! /bin/bash

if [[ $(realpath ..) != "$HOME" ]]; then
    echo "This dotfiles repo should be located in a subfolder of $HOME (eg. $HOME/.dotfiles)"
    exit 1
fi

stow --verbose=2 .
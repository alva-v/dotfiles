#! /bin/bash

set -e

install_codium_extensions() {
    xargs -L 1 codium --install-extension < ./non-home/codium_extensions
}

install_firefox_policies() {
    sudo mkdir -p /etc/firefox-esr/policies
    sudo mkdir -p /etc/firefox/policies
    cwd=$(pwd)
    sudo ln -s "$cwd/non-home/firefox-policies.json" /etc/firefox-esr/policies/policies.json
    sudo ln -s "$cwd/non-home/firefox-policies.json" /etc/firefox/policies/policies.json
}

if [[ $(realpath ..) != "$HOME" ]]; then
    echo "This dotfiles repo should be located in a subfolder of $HOME (eg. $HOME/.dotfiles)"
    exit 1
fi

stow --verbose=2 .
install_firefox_policies
install_codium_extensions

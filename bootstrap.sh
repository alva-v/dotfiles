#! /bin/bash

set -e

# VARIABLES
script_dir=$(dirname "$0")
parent_dir=$(realpath "$(dirname "$script_dir")")

# FUNCTIONS
check_dir() {
    if [[ "$parent_dir" != "$HOME" ]]; then
        echo "This dotfiles repo should be located in a subfolder of $HOME (eg. $HOME/.dotfiles)"
        exit 1
    fi
}

check_not_root() {
    if [[ $EUID -eq 0 ]]; then
        echo "Don't run this script as root"
        exit 1
    fi
}

install_codium_extensions() {
    xargs -L 1 codium --install-extension < "$script_dir"/non-home/codium-extensions
}

install_firefox_policies() {
    sudo mkdir -p /etc/firefox-esr/policies
    sudo mkdir -p /etc/firefox/policies
    sudo ln -s "$script_dir/non-home/firefox-policies.json" /etc/firefox-esr/policies/policies.json
    sudo ln -s "$script_dir/non-home/firefox-policies.json" /etc/firefox/policies/policies.json
}

# SCRIPT
check_not_root
check_dir
stow --adopt --verbose=2 --dir="$script_dir" .
install_firefox_policies
install_codium_extensions

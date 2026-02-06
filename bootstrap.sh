#! /bin/bash

set -e

# VARIABLES
script_dir=$(cd "$(dirname "$0")" &> /dev/null && pwd)
parent_dir=$(realpath "$(dirname "$script_dir")")
stowable_files=$(
    cd $script_dir &&
    find . -path "./.git" -prune -o -type f -print |
    sed "s|^\./||" |
    grep --invert-match --file=.stow-local-ignore
)

# FUNCTIONS
check_dir() {
    if [[ "$parent_dir" != "$HOME" ]]; then
        echo "This dotfiles repo should be located in a subfolder of $HOME (eg. $HOME/.dotfiles)"
        exit 1
    fi
}

check_dotfiles_changes() {
    changed_files=$(git -C "$script_dir" diff --name-only)
    changed_stowables=$(
        echo "$changed_files" |
        grep --fixed-string --line-regexp --file=<(echo "$stowable_files") ||
        changed_stowables="" # Prevents error if no match
    )
    if [[ -n "$changed_stowables" ]]; then
        echo "Some stowables files have been modified. Please commit, revert or stash them to prevent change override:"
        echo "$changed_stowables"
        exit 1
    fi
}

check_not_root() {
    if [[ $EUID -eq 0 ]]; then
        echo "Don't run this script as root"
        exit 1
    fi
}

install_arkenfox_directives() {
    # Get Firefox directory
    browser_dir=$(
        find "$HOME/.mozilla/firefox" \
             "$HOME/.config/mozilla/firefox" \
             -name "profiles.ini" 2>/dev/null | head -1 | xargs dirname
    )
    profiles_ini="$browser_dir/profiles.ini"

    # Create profile.ini if missing
    if [ ! -f "$profiles_ini" ]; then
        firefox --headless &>/dev/null &
        sleep 1
        kill -9 $!
    fi

    # Find profile directory
    profile=$(sed --quiet "/Default=.*\.default-release/ s/.*=//p" "$profiles_ini")
    profile_dir="$browser_dir/$profile"

    # Set Arkenfox overrides
    ln --no-dereference --symbolic --force \
        "$script_dir/non-home/firefox-user-overrides.js" \
        "$profile_dir/user-overrides.js"

    # Set up Arkenfox (-s: silent -p: specify profile dir)
    arkenfox-updater -sp "$profile_dir"

    # Clean up user.js
    if [ -f "$profile_dir/user.js" ]; then
        {
            pushd "$profile_dir" > /dev/null || return 1
            arkenfox-cleaner -s # -s: start immediately
            popd > /dev/null || return 1
        }
    fi
}

install_codium_extensions() {
    xargs -L 1 codium --install-extension < "$script_dir"/non-home/codium-extensions
}

install_dotfiles() {
    # Force symlink creation on existing files then revert them to wanted state
    stow --no-folding --restow --adopt --verbose=2 --dir="$script_dir" .
    echo "Restoring stowed files to their desired state..."
    git -C "$script_dir" restore $stowable_files
}

install_firefox_policies() {
    sudo mkdir -p /etc/firefox/policies
    sudo ln --no-dereference --symbolic --force \
        "$script_dir/non-home/firefox-policies.json" \
        /etc/firefox/policies/policies.json
}

# SCRIPT
check_not_root
check_dir
check_dotfiles_changes
install_dotfiles
install_firefox_policies
install_arkenfox_directives
install_codium_extensions
echo "Bootstrapping done!"
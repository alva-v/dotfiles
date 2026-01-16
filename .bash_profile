# Install Ruby Gems to ~/gems
GEM_HOME="$HOME/gems"
PATH="$HOME/gems/bin:$PATH"

# Change PEAR PHP version
PHP_PEAR_PHP_BIN=/usr/local/bin/php

# Node
PATH="/opt/node/bin:$PATH"
# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Vim as default editor
VISUAL=vim

export GEM_HOME PATH PHP_PEAR_PHP_BIN VISUAL

# ENV Variables
EMAIL=$(pass Dotfiles/email)
HEADSET=$(pass Dotfiles/MAC/headset)
SPEAKER=$(pass Dotfiles/MAC/speaker)
export EMAIL HEADSET SPEAKER

if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec startx
fi
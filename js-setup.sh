#!/bin/bash

source color.sh
source luxo.conf

echo "== js-setup.sh =="

if ! command -v node >/dev/null 2>&1;
then 
    print_yellow "Installing node..."
    brew install node
else
    print_yellow "node already installed"
fi

if ! command -v nvm >/dev/null 2>&1;
then 
    print_yellow "Installing nvm..."
    brew install nvm
    mkdir -p "$HOME/.nvm"
    cat << EOF >> ${ZSH_PROFILE_PATH}

# === added automatically by js-setup.sh === 
export NVM_DIR="\$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh" # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
# === added automatically by js-setup.sh ===

EOF
else
    print_yellow "nvm already installed"
fi

if ! command -v yarn >/dev/null 2>&1;
then 
	echo "Installing yarn..."
	npm install --global yarn
else
    print_yellow "yarn already installed"
fi

print_green "Done"


#!/bin/bash

source color.sh
source luxo.conf

echo "== git-setup.sh =="

GIT_IGNORE_GLOBAL="${HOME}/.gitignore_global"

if ! command -v git >/dev/null 2>&1;
then 
    print_yellow "Installing git..."
    brew install git
fi 

echo "Setting git username"
git config --global user.name ${GIT_NAME}

echo "Setting git email"
git config --global user.email ${GIT_EMAIL}

echo "Creating global .gitignore"
if [[ ! -f ${GIT_IGNORE_GLOBAL} ]]; 
then 
    echo "Creating default global gitignore: ${GIT_IGNORE_GLOBAL}"
    cat << EOF > ${GIT_IGNORE_GLOBAL}
*~
.DS_Store
EOF
fi

git config --global core.excludesfile ${GIT_IGNORE_GLOBAL}
echo "Setting pull to not rebase"
git config --global pull.rebase "false"
echo "Setting credentials helper"
git config --global credential.helper "osxkeychain"
echo "Setting default branch to main"
git config --global init.defaultBranch "main"
echo "Setting default editor"
git config --global core.editor "vim"
echo "Setting up signed commits"
# git config --global gpg.program $(which gpg)
# git config --global commit.gpgsign true
# GPG_KEY=$(gpg --list-secret-keys --keyid-format LONG | grep sec | awk '{print $2}' | sed 's/.*\///')
#if [ -z "$GPG_KEY" ]; then
#  echo "No GPG key found. Generating a new key..."
#  gpg --quick-generate-key "Your Name <your.email@example.com>" default default 1y
#  GPG_KEY=$(gpg --list-secret-keys --keyid-format LONG | grep sec | awk '{print $2}' | sed 's/.*\///')
#  echo "GPG key generated: $GPG_KEY"
#fi
# git config --global user.signingkey "$GPG_KEY" 


print_green "Done"

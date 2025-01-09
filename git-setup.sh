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
echo "Setting up signed commits"
git config --global commit.gpgsign true

print_green "Done"

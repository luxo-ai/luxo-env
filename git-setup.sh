#!/bin/bash

GIT_NAME="luxo-ai"
GIT_EMAIL="luxo.ai@proton.me"


if ! command -v git >/dev/null 2>&1;
then 
    echo "installing git..."
    brew install git
fi 

echo "Setting git username"
git config --global user.name ${GIT_NAME}
echo "Setting git email"
git config --global user.email ${GIT_EMAIL}
echo "Creating global .gitignore"
if [[ ! -f "$HOME/.gitignore_global" ]]; 
then 
    echo "Creating default global gitignore"
    cat << EOF > "$HOME/.gitignore_global"
*~
.DS_Store
EOF
fi
git config --global core.excludesfile "$HOME/.gitignore_global"
echo "Setting pull to not rebase"
git config --global pull.rebase "false"
echo "Setting credentials helper"
git config --global credential.helper "osxkeychain"
echo "Setting default branch to main"
git config --global init.defaultBranch "main"

echo "done"
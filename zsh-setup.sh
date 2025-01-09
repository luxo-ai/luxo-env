#!/bin/zsh

source color.sh
source luxo.conf

echo "== zsh-setup.sh =="

# check if zsh is installed
if ! command -v zsh >/dev/null 2>&1;
then 
    print_red "Error: zsh is not installed"
    exit 1
else
    # enable zsh
    zsh --version
    if [[ $(which zsh) != ${SHELL} ]];
    then
        print_yellow "Setting zsh as default shell"
        chsh -s $(which zsh)
    fi
fi

# create .zshrc if it doesn't exist
if [[ ! -f "${ZSH_PROFILE_PATH}" ]];
then
    print_yellow "Creating .zshrc"
    touch "${ZSH_PROFILE_PATH}"
fi

print_yellow "Enabling zsh extended globbing"
setopt EXTENDED_GLOB

# ========= PREZTO SETUP =========

PREZTO_DIR="${HOME}/.zprezto"
PREZTORC_PATH="${HOME}/.zpreztorc"

if [[ ! -d "${PREZTO_DIR}" ]];
then
  print_blue "Cloning sorin-ionescu/prezto to ${PREZTO_DIR}..."
  git clone --recursive "${PREZTO_ZSH_FRAMEWORK}" "${PREZTO_DIR}"
else
  print_yellow "Prezto already installed"
fi

echo "Symlinking prezto runcoms"
# symlink files excluding README.md (e.g. .preztorc) 
for RUNCOM_FILE in ${PREZTO_DIR}/runcoms/^README.md(.N); do
  TARGET_FILE="${HOME}/.${RUNCOM_FILE:t}"
    if [ -e "$TARGET_FILE" ]; then
        # append the contents of $rcfile to $target if not already present
        if ! grep -qF "$(cat $RUNCOM_FILE)" "$TARGET_FILE"; then
            echo "# === added automatically by zsh-setup.sh ===" >> "$TARGET_FILE"
            cat "$RUNCOM_FILE" >> "$TARGET_FILE"
            echo "# === added automatically by zsh-setup.sh ===" >> "$TARGET_FILE"
        fi
    else
      # if the file doesn't exist, create a symlink
      ln -s "$RUNCOM_FILE" "$TARGET_FILE"
    fi
done

echo "Enabling theme"
cat << EOF >> "$HOME/.zpreztorc"
# === added automatically by the zsh-setup.sh ===
zstyle ':prezto:module:editor' key-bindings 'vi'
# === added automatically by the zsh-setup.sh ===
EOF

print_green "Done"

#!/bin/bash

source color.sh
source luxo.conf

function add_binary() {
    local BINARY_NAME="${1}"
    local BINARY_PATH="${LOCAL_BINS_DIR}/${BINARY_NAME}"
    local BINARY_STR="${2}"

    if [[ ${#} < 2 ]];
    then
        print_red "Error: add_binary requires 2 arguments"
        return 1
    fi

    # if regular file exists
    if [[ -f ${BINARY_PATH} ]];
    then
        print_yellow "Binary ${BINARY_NAME} already exists"
    else
        print_yellow "Creating binary ${BINARY_NAME}"
        echo "${BINARY_STR}"
        sleep 3
        echo "${BINARY_STR}" | sed -e :a -e '/^\n*$/{$d;N;};/^\n*$/ba' > "${BINARY_PATH}"
    fi

    chmod +x ${BINARY_PATH}
}

# ======== SETUP ========

echo "== bin-setup.sh =="

echo "Creating local bin directory: ${LOCAL_BINS_DIR}"
mkdir -p ${LOCAL_BINS_DIR}

# add bin to path (via profile) if not already there
if [[ ":$PATH:" != *":${LOCAL_BINS_DIR}:"* ]]; 
then
    
    cat << EOF >> ${ZSH_PROFILE_PATH}

# === added automatically by bin-setup.sh === 
export PATH=${PATH:+"$PATH:"}${LOCAL_BINS_DIR}
# === added automatically by bin-setup.sh ===

EOF
else 
    print_yellow "Local bin already on path"
fi

# ======== ADD SCRIPTS HERE ========

GADD_SCRIPT="
#!/bin/bash
git add .
git reset HEAD .env
git status
"
# simple git command
add_binary "gadd" "${GADD_SCRIPT}"

print_green "Done"
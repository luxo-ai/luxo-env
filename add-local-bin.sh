#!/bin/bash

LOCAL_BINS="$HOME/.local/bin"
GADD_BINARY="${LOCAL_BINS}/gadd"

# add profile bin if doesn't exist already
if [[ ":$PATH:" != *":${LOCAL_BINS}:"* ]]; 
then
    mkdir -p ${LOCAL_BINS}
    cat << EOF >> ~/.zshrc
# added automatically by the add-local-bin.sh script
export PATH=${PATH:+"$PATH:"}${LOCAL_BINS}
EOF
else 
    echo "local bin already on path"
fi

# add my favorite simple git command
if [[ ! -f ${GADD_BINARY} ]];
then
    cat << EOF > ${GADD_BINARY}
#!/bin/bash
git add .
git reset HEAD .env
git status
EOF
chmod +x ${GADD_BINARY}
fi

#!/bin/bash

source color.sh

echo "== python-setup.sh =="

if ! command -v python3 >/dev/null 2>&1;
then 
    print_yellow "Installing python3..."
    brew install python3
else
    print_yellow "python3 already installed"
fi

print_green "Done"
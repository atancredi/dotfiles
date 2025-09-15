#!/bin/bash

BASH_CONFIG_FILE="${1:-$HOME/.bashrc}"

ALIAS_HEADER="# ===== https://github.com/atancredi/dotfiles/install_alias.sh ====="

if [ ! -f "$BASH_CONFIG_FILE" ]; then
    echo "$BASH_CONFIG_FILE does not exists."
    exit 1
fi

if ! grep -qF -- "$ALIAS_HEADER" "$BASH_CONFIG_FILE"; then
    echo -e "\n$ALIAS_HEADER" >> "$BASH_CONFIG_FILE"
fi

add_alias() {
    local alias_name="$1"
    local alias_cmd="$2"

    if ! grep -qF "alias $alias_name=" "$BASH_CONFIG_FILE"; then
        echo "alias $alias_name='$alias_cmd'" >> "$BASH_CONFIG_FILE"
        echo "Created alias: $alias_name"
    else
        echo "Alias '$alias_name' exists. Skipped."
    fi
}

# --- Actual aliases ---

add_alias 'll' 'ls -alF'
add_alias 'fuck' 'sudo $(history -p \!\!)'
add_alias 'hist' 'history | grep'
add_alias 'exe' 'chmod a+rx'
add_alias 'please' 'sudo apt-get'
add_alias 'getpath' 'echo $(pwd)/$1'


echo -e "\nAlias added to '$BASH_CONFIG_FILE'"
echo "To make them effective run:"
echo "source $HOME/.bashrc"
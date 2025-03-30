#!/usr/bin/env bash

selected=$(find ~/.passw -type f | fzf)

if [[ -z $selected ]]; then
    exit 0
fi

echo $(openssl aes-256-cbc -a -d -pbkdf2 -salt -in ${selected}) | wl-copy

#!/usr/bin/env bash

selected=$(find ~/.passw -type f | fzf)

if [[ -z $selected ]]; then
    exit 0
fi

DECRYPTED=$(openssl aes-256-cbc -a -d -pbkdf2 -salt -in ${selected})
if [ $? -eq 0 ]; then
    clear
    echo -n $DECRYPTED
    wl-copy $DECRYPTED
fi

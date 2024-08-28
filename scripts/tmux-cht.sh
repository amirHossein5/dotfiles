#!/usr/bin/env bash

selected=`cat ~/.tmux-cht-items | fzf`

echo "selected: " $selected

read -p "query: " query

query=`echo $query | tr " " +`

tmux neww bash -c "printf 'curl cheat.sh/$selected/$query \n--------------------------------\n' && curl cheat.sh/$selected/$query && while [ : ]; do sleep 1; done"

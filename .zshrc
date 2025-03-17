[ "$(tty)" = "/dev/tty1" ] && exec sway

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
HIST_STAMPS="yyyy-mm-dd"

plugins=( history-substring-search )

source $ZSH/oh-my-zsh.sh

alias cat="batcat"
alias am="php artisan migrate"
alias amfs="php artisan migrate:fresh --seed"

bindkey -v
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

export XDG_CURRENT_DESKTOP=sway
export XDG_CONFIG_HOME=$HOME/.config

export PATH=$HOME/.local/bin:$HOME/.local/scripts:$HOME/.config/composer/vendor/bin:./vendor/bin:$HOME/go/bin:$HOME/.cargo/bin:$PATH

if [ -z "$SSH_AUTH_SOCK" ]; then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi

[ "$(tty)" = "/dev/tty1" ] && exec sway

export TERM='screen-256color'

if [ -f /etc/skel/.bashrc ]; then
    . /etc/skel/.bashrc
fi

alias a="php artisan"
alias am="php artisan migrate"
alias amfs="php artisan migrate:fresh --seed"
alias gs="git status"

export XDG_CURRENT_DESKTOP=sway
export XDG_CONFIG_HOME=$HOME/.config

export PATH=$HOME/.local/bin:$HOME/.local/scripts:$HOME/.config/composer/vendor/bin:./vendor/bin:$HOME/go/bin:$HOME/.cargo/bin:$PATH

if [ -z "$SSH_AUTH_SOCK" ]; then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi

stty -ixon
set -o vi

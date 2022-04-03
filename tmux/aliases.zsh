alias tmux='tmux -f "$XDG_CONFIG_HOME"/tmux/tmux.conf'
alias tm='tmux attach -t main || tmux new -s main; exit'
alias takeover="tmux detach -a"

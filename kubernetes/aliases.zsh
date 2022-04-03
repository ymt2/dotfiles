alias k=kubectl
alias -g Kn='$(kubens | fzf)'
alias -g Kp='$(k get po | fzf | awk "{print \$1}")'

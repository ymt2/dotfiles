alias gcd='cd $(ghq root)/$(ghq list | fzf)'
alias gbr='hub browse $(ghq list | fzf | cut -d "/" -f 2,3)'

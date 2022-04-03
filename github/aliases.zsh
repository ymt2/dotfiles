alias -g GHi='$(gh issue list | fzf --reverse | awk "{print \$1}")'

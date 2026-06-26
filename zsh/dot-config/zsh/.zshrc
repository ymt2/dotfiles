bindkey -e

autoload -Uz add-zsh-hook
autoload -Uz colors && colors
autoload -Uz history-search-end
autoload -Uz zed
autoload -Uz compinit && compinit
autoload -Uz predict-on && predict-on
autoload -Uz zmv
autoload -Uz promptinit && promptinit

setopt transient_rprompt
setopt auto_cd
setopt auto_pushd
setopt list_packed
setopt pushd_minus
setopt noautoremoveslash
setopt nolistbeep
setopt hist_ignore_dups
setopt hist_ignore_space
setopt share_history
setopt prompt_subst
setopt auto_remove_slash
setopt always_last_prompt
setopt extended_glob
setopt correct
setopt correct_all
setopt complete_aliases
setopt interactivecomments

prompt_mytheme_setup() {
  local me
  if [[ -n $SSH_CONNECTION ]]; then
    me="%n@%m"
  elif [[ $LOGNAME != $USER ]]; then
    me="%n"
  fi

  local host
  if [[ -n $me ]]; then
    host="%{$fg[green]%}$me%{$reset_color%}:"
  fi

  local current_dir="%{$fg[blue]%}%c "
  local bg="%{$fg[yellow]%}%(1j.↓%j .)"
  local return_status="%(?.%F{magenta}.%F{yellow})❯%f "

  PS1="$host$current_dir$bg$return_status"
}
prompt_themes+=( mytheme )
prompt mytheme

zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>='
export HISTFILE=~/.zsh_history
export HISTSIZE=999999
export SAVEHIST=999999

if [ $UID = 0 ]; then
    unset HISTFILE
    SAVEHIST=0
fi

zstyle ':completion:*' menu select interactive

alias zmv='noglob zmv -W'

# No arguments: `git status`
# With arguments: acts like `git`
g() {
  if [[ $# > 0 ]]; then
    git $@
  else
    git status
  fi
}

# Complete g like git
compdef g=git

alias gcd='cd $(ghq root)/$(ghq list | fzf)'
alias gwt="cd \$(git-wt | fzf --header-lines=1 | awk '{if (\$1 == \"*\") print \$2; else print \$1}')"

# load user .zshrc configuration file
[ -f "$ZDOTDIR/.zshrc.local" ] && source "$ZDOTDIR/.zshrc.local"

[ -n "$EAT_SHELL_INTEGRATION_DIR" ] && source "$EAT_SHELL_INTEGRATION_DIR/zsh"

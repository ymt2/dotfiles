all: init
	@stow --dotfiles -v emacs git kitty aws skk systemd tig tmux xmonad zsh

init:
	@git submodule update --init --recursive

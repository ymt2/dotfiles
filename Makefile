all: init
	@stow --dotfiles -v emacs git kitty aws skk systemd tig tmux

init:
	@git submodule update --init --recursive

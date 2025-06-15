all: init
	@stow --dotfiles -v emacs git kitty aws skk systemd tig tmux xmonad

init:
	@git submodule update --init --recursive

all: init
	@stow --dotfiles -v emacs git kitty aws skk systemd

init:
	@git submodule update --init --recursive

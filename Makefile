all: init
	@stow --dotfiles -v emacs git kitty aws skk systemd tig

init:
	@git submodule update --init --recursive

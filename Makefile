all: init
	@stow --dotfiles -v emacs git kitty aws skk

init:
	@git submodule update --init --recursive

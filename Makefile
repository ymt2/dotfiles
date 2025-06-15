all: init
	@stow --dotfiles -v emacs git kitty

init:
	@git submodule update --init --recursive

all: init
	@stow --dotfiles -v emacs git kitty aws

init:
	@git submodule update --init --recursive

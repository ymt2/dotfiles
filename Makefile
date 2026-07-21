PACKAGES := $(sort $(shell find . -maxdepth 1 -type d -not -name '.' -not -name '.*' | sed 's|./||'))

all: init
	@mkdir -p ~/.local/share
	@stow --dotfiles -v $(PACKAGES)

init:
	@git submodule update --init --recursive

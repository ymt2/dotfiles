PACKAGES := $(sort $(shell find . -maxdepth 1 -type d -not -name '.' -not -name '.*' | sed 's|./||'))

# dbus installs into ~/.local, a standard XDG directory shared with other
# programs. Stowing it with folding would turn ~/.local itself into a symlink
# pointing back into this repo (when ~/.local does not exist yet), so it is
# stowed separately with --no-folding to keep ~/.local and its subdirectories
# as real directories and only symlink the leaf files.
NO_FOLD_PACKAGES := dbus
FOLD_PACKAGES := $(filter-out $(NO_FOLD_PACKAGES),$(PACKAGES))

all: init
	@stow --dotfiles -v $(FOLD_PACKAGES)
	@stow --dotfiles --no-folding -v $(NO_FOLD_PACKAGES)

init:
	@git submodule update --init --recursive

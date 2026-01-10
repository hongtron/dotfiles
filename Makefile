SHELL = /bin/bash
DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
PATH := $(DOTFILES_DIR)/scripts/dot-bin:$(PATH)

PACKAGES = $(shell find $(DOTFILES_DIR) \
	-maxdepth 1 -mindepth 1 -type d \
	! -path $(DOTFILES_DIR)/.git -exec basename {} \;)

.PHONY: $(PACKAGES)

ifeq ($(shell uname),Darwin)
OS := macos
else
OS := linux
endif

install: link-all setup-vim

link-all: stow-$(OS) $(addprefix link-,$(PACKAGES))

unlink-all: stow-$(OS) $(addprefix unlink-,$(PACKAGES))

$(addprefix link-,$(PACKAGES)): stow-$(OS)
	stow --target $(HOME) --dotfiles $(@:link-%=%)

$(addprefix unlink-,$(PACKAGES)): stow-$(OS)
	stow --target $(HOME) --delete --dotfiles $(@:unlink-%=%)

setup-vim:
	is-executable vim && vim +PlugInstall +qall || echo "Vim is not installed"

stow-macos: brew
	is-executable stow || brew install stow

stow-linux: apt
	is-executable stow || apt-get -y install stow

brew:
	is-executable brew || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash

apt:
	apt-get update
	apt-get upgrade -y

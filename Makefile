SHELL = /bin/bash
DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
PATH := $(DOTFILES_DIR)/bin:$(PATH)

PACKAGES = $(shell find $(DOTFILES_DIR) \
	! -path $(DOTFILES_DIR) ! -path $(DOTFILES_DIR)/.git \
	-maxdepth 1 -type d -exec basename {} +)

.PHONY: $(PACKAGES)

ifeq ($(shell uname),Darwin)
OS := macos
else
OS := linux
endif

link-all: $(addprefix link-,$(PACKAGES))

unlink-all: $(addprefix unlink-,$(PACKAGES))

$(addprefix link-,$(PACKAGES)):
	stow --dotfiles $(@:link-%=%)

$(addprefix unlink-,$(PACKAGES)):
	stow --delete --dotfiles $(@:unlink-%=%)

stow-macos: brew
	is-executable stow || brew install stow

stow-linux: apt
	is-executable stow || apt-get -y install stow

brew:
	is-executable brew || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash

apt:
	apt-get update
	apt-get upgrade -y

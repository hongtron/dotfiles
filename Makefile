SHELL = /bin/bash
DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
PATH := $(DOTFILES_DIR)/scripts/dot-bin:$(PATH)

PACKAGES = $(shell find $(DOTFILES_DIR) \
	! -path $(DOTFILES_DIR) ! -path $(DOTFILES_DIR)/.git \
	-maxdepth 1 -type d -exec basename {} +)

.PHONY: $(PACKAGES)

ifeq ($(shell uname),Darwin)
OS := macos
else
OS := linux
endif

install: link-all setup-neovim setup-devenv

link-all: stow-$(OS) $(addprefix link-,$(PACKAGES))

unlink-all: stow-$(OS) $(addprefix unlink-,$(PACKAGES))

$(addprefix link-,$(PACKAGES)): stow-$(OS)
	stow --dotfiles $(@:link-%=%)

$(addprefix unlink-,$(PACKAGES)): stow-$(OS)
	stow --delete --dotfiles $(@:unlink-%=%)

setup-devenv: compose_path = /usr/local/etc/devenv
setup-devenv:
	[ -d $(compose_path) ] || mkdir $(compose_path)
	[ -L $(compose_path)/docker-compose.yml ] && echo "devenv already configured" || \
		ln -s $(DOTFILES_DIR)/docker-compose.yml $(compose_path)/docker-compose.yml

setup-neovim: link-neovim
	is-executable nvim && nvim +PlugInstall +qall || echo "Neovim is not installed"

stow-macos: brew
	is-executable stow || brew install stow

stow-linux: apt
	is-executable stow || apt-get -y install stow

brew:
	is-executable brew || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash

apt:
	apt-get update
	apt-get upgrade -y

SHELL = /bin/bash
DOTFILES_DIR := $(shell cd $(dir $(abspath $(firstword $(MAKEFILE_LIST)))) && pwd)
PATH := $(DOTFILES_DIR)/scripts/dot-bin:$(PATH)
STOW_VERSION ?= 2.4.1
STOW_PREFIX ?= /usr/local

PACKAGES = $(filter-out .git,$(patsubst %/,%,$(notdir $(wildcard $(DOTFILES_DIR)/*/))))

.PHONY: $(PACKAGES) link-all unlink-all link-% unlink-%

ifeq ($(shell uname),Darwin)
OS := macos
else
OS := linux
endif

install: link-all setup-vim

link-all: stow-$(OS) $(addprefix link-,$(PACKAGES))

unlink-all: stow-$(OS) $(addprefix unlink-,$(PACKAGES))

link-%: stow-$(OS)
	stow --target $(HOME) --dotfiles $*

unlink-%: stow-$(OS)
	stow --target $(HOME) --delete --dotfiles $*

setup-vim:
	@if is-executable vim; then \
		if [ -f "$(HOME)/.vim/autoload/plug.vim" ]; then \
			vim +PlugInstall +qall; \
		else \
			echo "vim-plug not found; run make link-vim or make install first"; \
		fi; \
	else \
		echo "Vim is not installed"; \
	fi

stow-macos: brew
	is-executable stow || brew install stow

stow-linux: apt
	@if is-executable stow; then \
		stow_version=$$(stow --version | awk 'NR==1{print $$NF}'); \
		if [ "$$stow_version" = "$(STOW_VERSION)" ]; then \
			true; \
		else \
			$(MAKE) install-stow; \
		fi; \
	else \
		$(MAKE) install-stow; \
	fi

install-stow:
	@tmpdir=$$(mktemp -d); \
	curl -fsSL https://ftp.gnu.org/gnu/stow/stow-$(STOW_VERSION).tar.gz -o $$tmpdir/stow.tar.gz; \
	tar -xzf $$tmpdir/stow.tar.gz -C $$tmpdir; \
	cd $$tmpdir/stow-$(STOW_VERSION) && ./configure --prefix=$(STOW_PREFIX) && make && make install; \
	rm -rf $$tmpdir

brew:
	is-executable brew || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash

apt:
	apt-get update
	apt-get upgrade -y

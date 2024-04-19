PREFIX = $(HOME)/.local
BIN = /usr/bin
MAN_DIR = /usr/share/man/man1
SUDO := sudo
OS := $(shell uname -s)

# Check if the operating system is Linux
ifeq ($(OS),Linux)
	BIN = /usr/bin
	MAN_DIR = /usr/share/man/man1
endif

# Check if the operating system is Mac OS X
ifeq ($(OS),Darwin)
	BIN = /usr/local/bin
	MAN_DIR = /usr/local/share/man/man1
endif

all:
	@echo Run \'make install\' to install BashPass.
	@echo Run \'make update\' to update BashPass.
	@echo Run \'make uninstall\' to uninstall BashPass.

install:
	@echo Installing BashPass...
	@$(SUDO) install -v -m755 bashpass $(BIN)
	@$(SUDO) install -v -m644 docs/bashpass.1.gz $(MAN_DIR)
	@$(SUDO) install -v -m644 docs/bashpass.conf.1.gz $(MAN_DIR)
	@echo BashPass installed successfully!

update:
	@echo Updating BashPass...
	@$(SUDO) install -v -m755 bashpass $(BIN)
	@$(SUDO) install -v -m644 docs/bashpass.1.gz $(MAN_DIR)
	@$(SUDO) install -v -m644 docs/bashpass.conf.1.gz $(MAN_DIR)
	@echo BashPass updated successfully!

uninstall:
	@echo Uninstalling BashPass...
	@$(SUDO) rm -vf $(BIN)/bashpass
	@$(SUDO) rm -vf $(MAN_DIR)/bashpass.1.gz
	@$(SUDO) rm -vf $(MAN_DIR)/bashpass.conf.1.gz
	@echo BashPass uninstalled successfully!
	@echo Bye, have a nice day!

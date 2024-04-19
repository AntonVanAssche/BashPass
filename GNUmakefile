PREFIX = $(HOME)/.local
BIN = /usr/bin
MAN_DIR = /usr/share/man/man1
OS := $(shell uname -s)

# Check if the operating system is Linux
ifeq ($(OS),Linux)
	BIN = /usr/bin
	MAN_DIR = /usr/share/man/man1
endif

# Check if the operating system is macOS X
ifeq ($(OS),Darwin)
	BIN = /usr/local/bin
	MAN_DIR = /usr/local/share/man/man1
endif

all:
	@echo Run \'make install\' to install BashPass.
	@echo Run \'make uninstall\' to uninstall BashPass.

install:
	@echo Installing BashPass...
	install -v -m755 bashpass $(BIN)
	install -v -m644 docs/bashpass.1.gz $(MAN_DIR)
	install -v -m644 docs/bashpass.conf.1.gz $(MAN_DIR)
	@echo BashPass installed successfully!

uninstall:
	@echo Uninstalling BashPass...
	rm -vf $(BIN)/bashpass
	rm -vf $(MAN_DIR)/bashpass.1.gz
	rm -vf $(MAN_DIR)/bashpass.conf.1.gz
	@echo BashPass uninstalled successfully!
	@echo Bye, have a nice day!

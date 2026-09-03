BIN = /usr/bin
MAN_DIR = /usr/share/man/man1
COMPLETION_DIR = /etc/bash_completion.d

all:
	@echo Run \'make install\' to install BashPass.
	@echo Run \'make uninstall\' to uninstall BashPass.

install:
	@echo Installing BashPass...
	install -v -m755 bashpass $(BIN)
	install -v -m644 man/bashpass.1 $(MAN_DIR)
	@echo BashPass installed successfully!

uninstall:
	@echo Uninstalling BashPass...
	rm -vf $(BIN)/bashpass
	rm -vf $(MAN_DIR)/bashpass.1
	@echo BashPass uninstalled successfully!
	@echo Bye, have a nice day!

install-completion:
	@echo Installing BashPass Bash completion...
	install -v -m644 completion/bashpass $(COMPLETION_DIR)
	@echo BashPass Bash completion installed successfully!

uninstall-completion:
	@echo Uninstalling BashPass Bash completion...
	rm -vf $(COMPLETION_DIR)/bashpass
	@echo BashPass Bash completion uninstalled successfully!

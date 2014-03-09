# Makefile
# Usage:
#   make install
#

install:
	ln -vs ~/dotfiles/.ssh/* ~/.ssh 
	ln -vs ~/dotfiles/.??* ~/

uninstall:
	find ~/ -maxdepth 2 -type l -exec rm -v "{}" \;

# Makefile
# Usage:
#   make install
#
CWD:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

install:
	@echo Installing...
	find "$(CWD)" -maxdepth 1 -name ".*" -type f -exec ln -vs {} ~/ ';'
	find "$(CWD)/.ssh" -maxdepth 1 -type f -exec ln -vs {} ~/.ssh/ ';'

clean:
	@echo Cleaning...
	find ~ -maxdepth 1 -name ".*" -type l -print -delete
	find ~/.ssh -maxdepth 1 -type l -print -delete

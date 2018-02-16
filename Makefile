# Makefile
# Recommended way is to clone/place this folder in your HOME.
# Usage:
#   make install
#
CWD:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
DIR:=$(shell basename $(CWD))

install:
	@echo Installing...
	cd "$(CWD)/.."; find "$(DIR)" -maxdepth 1 -name ".*" -type f -exec ln -vs {} ~/ ';'
	cd "$(CWD)/.."; find "$(DIR)/.ssh" -maxdepth 1 -type f -exec ln -vs {} ~/.ssh/ ';'

clean:
	@echo Cleaning...
	find ~ -maxdepth 1 -name ".*" -type l -print -delete
	find ~/.ssh -maxdepth 1 -type l -print -delete

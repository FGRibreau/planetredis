#!/bin/sh

set -e

if [ ! -e ~/repos/planetmongo-src ]; then
	mkdir -p ~/repos
	cd ~/repos
	GIT_SSH_COMMAND='git -i ~/.ssh/id_rsa-pm' git clone git@github.com:xaprb/planetmongo-src
	cp -R planetmongo-src planetmongo-web
fi
cd ~/repos/planetmongo-web
git checkout gh-pages
cd ~/repos/planetmongo-src
GIT_SSH_COMMAND='git -i ~/.ssh/id_rsa-pm' git pull
./planet.py config.ini
cd ~/repos/planetmongo-web
git add --all .
git commit -am "generate $(date)"
GIT_SSH_COMMAND='git -i ~/.ssh/id_rsa-pm' git push

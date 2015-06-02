#!/bin/sh

set -e

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa-pm
ssh-add -l
if [ ! -e ~/repos/planetmongo-src ]; then
	mkdir -p ~/repos
	cd ~/repos
	git clone git@github.com:xaprb/planetmongo-src
	cp -R planetmongo-src planetmongo-web
fi
cd ~/repos/planetmongo-web
git checkout gh-pages
cd ~/repos/planetmongo-src
git pull
./planet.py config.ini
cd ~/repos/planetmongo-web
git add --all .
git commit -am "generate $(date)"
git push

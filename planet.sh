#!/bin/sh

set -e

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa-pr
ssh-add -l
if [ ! -e ~/repos/planetredis-web ]; then
	mkdir -p ~/repos
	cd ~/repos
	git clone git@github.com:VividCortex/planetredis-src
	cp -R planetredis-src planetredis-web
fi
cd ~/repos/planetredis-web
git checkout gh-pages
git pull
cd ~/repos/planetredis-src
git pull
./planet.py config.ini
cd ~/repos/planetredis-web
git add --all .
git commit -am "generate $(date)"
git push

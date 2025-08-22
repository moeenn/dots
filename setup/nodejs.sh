#! /bin/sh

VERSION="24"
SCRIPT_URL="https://deb.nodesource.com/setup_${VERSION}.x"
SCRIPT_NAME="nodejs_install"
CURRENT_DIR=$(pwd)

#cd /tmp/
#curl -sL $SCRIPT_URL >> $SCRIPT_NAME
#chmod +x ./$SCRIPT_NAME
#sudo ./$SCRIPT_NAME
#cd $CURRENT_DIR

sudo dnf install -y nodejs24
ln -s /bin/node-24 ~/.local/bin/node
ln -s /bin/npm-24 ~/.local/bin/npm

npm config set prefix=$HOME/.npm
echo 'updating npm...'
npm i -g npm typescript-language-server

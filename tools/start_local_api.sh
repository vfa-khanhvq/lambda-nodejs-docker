#!/bin/sh
set -e

PWD=`pwd`
cd `dirname $0`/..

# Install node module for local
if [ ! -d "common-layers/nodejs" ]; then
    mkdir -p common-layers/nodejs
fi
# Copy package json
cp -a package.json common-layers/nodejs
cp -a yarn.lock common-layers/nodejs
# Install node modules
cd common-layers/nodejs && yarn
cd -

# Start local api
sam local start-api --skip-pull-image --env-vars local.env.json

cd $PWD

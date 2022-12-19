#!/bin/sh
set -e

PWD=`pwd`
cd `dirname $0`/..

# Start database dynamodb
OPTS="-f docker-compose.yml"
if docker-compose $OPTS ps -q dynamo > /dev/null 2>&1; then
    docker-compose $OPTS up -d dynamo
    sleep 5
fi

# Install node module for test
if [ ! -d "node_modules" ]; then
    if [ -f package-lock.json ]; then
        npm ci
    else
        npm i
    fi
fi

# Setup test target
REPORTER_TARGET="spec"
TEST_TARGET="tests/test_files/"

CMD=''
if [ "$1" = "coverage" ]; then
    CMD='./node_modules/.bin/nyc'
    if [ "$2" != "" ]; then
        # Test specified file
        TEST_TARGET="tests/test_files/$2.js"
    fi
else
    if [ "$1" != "" ]; then
        # Test specified file
        TEST_TARGET="tests/test_files/$1.js"
    fi
fi

# Run unit test
$CMD ./node_modules/.bin/mocha $TEST_TARGET \
    --reporter $REPORTER_TARGET \
    --recursive \
    --require tests/config/env_test \
    --require tests/common/prepare_data \
    --timeout 36000 \
    --exit || echo done

cd $PWD

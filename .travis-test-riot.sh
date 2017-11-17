#!/bin/bash
#
# script which is run by the travis build (after `npm run test`).
#
# clones saphar-web develop and runs the tests against our version of react-sdk.

set -ev

SAPHAR_WEB_DIR=saphar-web
REACT_SDK_DIR=`pwd`

curbranch="${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}"
echo "Determined branch to be $curbranch"

git clone https://github.com/bennabiy/saphar-web.git \
    "$SAPHAR_WEB_DIR"

cd "$SAPHAR_WEB_DIR"

git checkout "$curbranch" || git checkout develop

mkdir node_modules
npm install

# use the version of js-sdk we just used in the react-sdk tests
rm -r node_modules/matrix-js-sdk
ln -s "$REACT_SDK_DIR/node_modules/matrix-js-sdk" node_modules/matrix-js-sdk

# ... and, of course, the version of react-sdk we just built
rm -r node_modules/matrix-react-sdk
ln -s "$REACT_SDK_DIR" node_modules/matrix-react-sdk

npm run test

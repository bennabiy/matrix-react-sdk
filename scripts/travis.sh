#!/bin/sh

set -ex

npm run test
./.travis-test-saphar.sh

# run the linter, but exclude any files known to have errors or warnings.
npm run lintwithexclusions

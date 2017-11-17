#!/bin/bash

# Exit on fail
set -e

bundle check || bundle install --binstubs="$BUNDLE_BIN"

exec "$@"

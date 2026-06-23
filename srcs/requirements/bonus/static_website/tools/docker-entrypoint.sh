#!/bin/sh

set -eu

npm install

npm next build

exec "$@"

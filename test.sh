#/bin/sh

# to run this, first spin up the dev server

set -x

curl http://localhost:3000/1.0/get_version
curl http://localhost:3000/1.1/get_version
curl http://localhost:3000/get_version

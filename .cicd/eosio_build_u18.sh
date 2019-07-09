#!/usr/bin/env bash
set -eu

rm -rf ./eos
docker build -t eos-dev -f Dockerfile-U18 .
git clone https://github.com/EOSIO/eos
cd eos
git checkout release/1.8.x
git submodule update --init --recursive

docker run --rm -v /Users/scott.arnette/Repos/eos/.cicd/eos:/eos eos-dev bash -c "mkdir /eos/build && cd /eos/build && cmake -DCMAKE_BUILD_TYPE='Release' -DCORE_SYMBOL_NAME='SYS' -DOPENSSL_ROOT_DIR='/usr/include/openssl' -DBUILD_MONGO_DB_PLUGIN=true /eos && make -j$(nproc)"

cd .. && rm -rf eos
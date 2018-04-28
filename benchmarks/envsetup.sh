#!/bin/bash

BUILD_DIR=$(pwd)/../libs

# UNCOMMENT FOR UNIX
# sudo apt-get install \
#     g++ \
#     cmake \
#     libboost-all-dev \
#     libevent-dev \
#     libdouble-conversion-dev \
#     libgoogle-glog-dev \
#     libgflags-dev \
#     libiberty-dev \
#     liblz4-dev \
#     liblzma-dev \
#     libsnappy-dev \
#     make \
#     zlib1g-dev \
#     binutils-dev \
#     libjemalloc-dev \
#     libssl-dev \
#     pkg-config

# Get folly library and build it
mkdir $BUILD_DIR
cd $BUILD_DIR
wget https://github.com/facebook/folly/archive/v2018.04.23.00.tar.gz

# Untar and move
tar xzvf v2018.04.23.00.tar.gz
mv folly-2018.04.23.00 folly

mkdir _build && cd _build
cmake configure ..
make -j $(nproc)
make install
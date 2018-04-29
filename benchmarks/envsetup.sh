#!/bin/bash

BUILD_DIR=$(pwd)/../libs

# UNCOMMENT FOR UNIX
sudo apt-get install \
    g++ \
    cmake \
    libboost-all-dev \
    libevent-dev \
    libdouble-conversion-dev \
    libgoogle-glog-dev \
    libgflags-dev \
    libiberty-dev \
    liblz4-dev \
    liblzma-dev \
    libsnappy-dev \
    make \
    zlib1g-dev \
    binutils-dev \
    libjemalloc-dev \
    libssl-dev \
    pkg-config

# Untar the Folly library and move to build dir
mkdir $BUILD_DIR 
cd $BUILD_DIR
tar xzvf v2018.04.23.00.tar.gz && mv folly-2018.04.23.00 folly
cd folly
mkdir _build
cd _build

# Make the Folly library
cmake configure ..
make -j $(nproc)
sudo make install
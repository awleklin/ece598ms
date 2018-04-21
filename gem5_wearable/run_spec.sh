#!/bin/bash

GEM5_HOME=$M5_PATH
KERNEL=$GEM5_HOME/binaries/vmlinux.aarch32.ll_20131205.0-gem5
DTB=$GEM5_HOME/binaries/vexpress.aarch32.ll_20131205.0-gem5.4cpu.dtb
IMAGE=$GEM5_HOME/disks/memcached.apache.latest.spec06.2gb.img

if [ "$1" == "bzip2" ]; then
  SCRIPT=$GEM5_HOME/scripts/bzip.sh
elif [ "$1" == "mcf" ]; then
  SCRIPT=$GEM5_HOME/scripts/mcf.sh
elif [ "$1" == "soplex" ]; then
  SCRIPT=$GEM5_HOME/scripts/soplex.sh
fi

$GEM5_HOME/build/ARM/gem5.opt --debug-flags=Cache,TLB --debug-file=$GEM5_HOME/m5out/debug.log $GEM5_HOME/configs/example/fs.py --disk-image=$IMAGE --kernel=$KERNEL --dtb-filename=$DTB --script=$SCRIPT --num-cpus=2 --machine-type=VExpress_EMM --caches --l2cache --cpu-type=O3_ARM_v7a_3 


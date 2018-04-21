#!/bin/bash

GEM5_HOME=$M5_PATH
SCRIPT_HOME=$GEM5_HOME/asimbench_boot_scripts
KERNEL=$GEM5_HOME/binaries/vmlinux.smp.ics.arm.asimbench.2.6.35
DTB=$GEM5_HOME/binaries/armv7_gem5_v1_2cpu.dtb
IMAGE=$GEM5_HOME/disks/ARMv7a-ICS-Android.SMP.Asimbench-v3.img

if [ "$1" == "adobe" ]; then
  SCRIPT=$GEM5_HOME/$SCRIPT_HOME/adobe.rcS
elif [ "$1" == "mcf" ]; then
  SCRIPT=$GEM5_HOME/$SCRIPT_HOME/mcf.sh
elif [ "$1" == "soplex" ]; then
  SCRIPT=$GEM5_HOME/$SCRIPT_HOME/soplex.sh
fi

$GEM5_HOME/build/ARM/gem5.opt --debug-flags=Cache,TLB --debug-file=$GEM5_HOME/m5out/debug.log $GEM5_HOME/configs/example/fs.py --disk-image=$IMAGE --kernel=$KERNEL --dtb-filename=$DTB --script=$SCRIPT --num-cpus=2 --caches --l2cache --cpu-type=O3_ARM_v7a_3 


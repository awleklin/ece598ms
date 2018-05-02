#!/bin/bash

GEM5_HOME=$M5_PATH
CMD=
OPTS=

if [ "$1" == "fitness" ]; then
  CMD=./benchmarks/fitnessTrack/fitnessTrack
elif [ "$1" == "urlparser" ]; then
  CMD=./benchmarks/urlParser/parser
  OPTS='-o 50'
elif [ "$1" == "x264" ]; then
  CMD=./benchmarks/x264/example
  OPTS='-o 1'
elif [ "$1" == "aes" ]; then
  CMD=./benchmarks/locusApps/testbench/aes/aes
elif [ "$1" == "astar" ]; then
  CMD=./benchmarks/locusApps/testbench/astar/astar
elif [ "$1" == "2dconv" ]; then
  CMD=./benchmarks/locusApps/testbench/2dconv/2dconv
elif [ "$1" == "ecg" ]; then
  CMD=./benchmarks/locusApps/testbench/ecg/ecg
elif [ "$1" == "histogram" ]; then
  CMD=./benchmarks/locusApps/testbench/histogram/histogram
elif [ "$1" == "svm" ]; then	
  CMD=./benchmarks/locusApps/testbench/svm/svm
elif [ "$1" == "soplex" ]; then	
  $M5_PATH/build/ARM/gem5.opt $M5_PATH/configs/example/se.py \
  --num-cpus=1 --cpu-type=O3_ARM_v7a_3 --cpu-clock=1.2GHz 	 \
  --caches --l2cache --l1d_size=64kB --l1i_size=32kB 		 \
  --l2_size=512kB --l1d_assoc=4 --l1i_assoc=2 --l2_assoc=16  \
  --mem-type=LPDDR3_1600_1x32 --mem-size=1GB 				 \
  -c ./benchmarks/spec/soplex/soplex_base.arm -o '-m10000 ./benchmarks/spec/soplex/test.mps'
  exit 0
elif [ "$1" == "video" ]; then
  CMD=./benchmarks/video_processing/process
  OPTS='-o 1'
fi

# Call gem5 ARM with a single core and Qualcomm Snapdragon 410C/ARMv7 Cortex A53 Configurations
# ArmTLB.py has parameters for the TLB (1 Level, Separate iTLB/dTLB 256 entries each, 1kiB Walker Cache)
$GEM5_HOME/build/ARM/gem5.opt $GEM5_HOME/configs/example/se.py 				  \
					--num-cpus=1 --cpu-type=O3_ARM_v7a_3 --cpu-clock=1.2GHz   \
					--caches --l1d_size=1kB --l1i_size=1kB		  \
					--l1d_assoc=4 --l1i_assoc=2 \
 					--mem-type=LPDDR3_1600_1x32 --mem-size=1GB				  \
 					 -c $CMD $OPTS


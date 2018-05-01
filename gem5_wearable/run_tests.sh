#!/bin/bash

mkdir results_512kB_L2
./run_wearables512kB.sh urlparser > /dev/null 2>&1 &
sleep 600
killall -2 gem5.opt
mv m5out parser_out
./run_wearables512kB.sh aes
mv m5out aes_out
./run_wearables512kB.sh astar
mv m5out astar_out
./run_wearables512kB.sh video  > /dev/null 2>&1 &
sleep 600
killall -2 gem5.opt
mv m5out video_out
./run_wearables512kB.sh fitness  > /dev/null 2>&1 &
sleep 600
killall -2 gem5.opt
mv m5out fitness_out
mv *_out results_512kB_L2/

mkdir results_256kB_L2
./run_wearables256kB.sh urlparser  > /dev/null 2>&1 &
sleep 600
killall -2 gem5.opt
mv m5out parser_out
./run_wearables256kB.sh aes
mv m5out aes_out
./run_wearables256kB.sh astar
mv m5out astar_out
./run_wearables256kB.sh video  > /dev/null 2>&1 &
sleep 600
killall -2 gem5.opt
mv m5out video_out
./run_wearables256kB.sh fitness  > /dev/null 2>&1 &
sleep 600
killall -2 gem5.opt
mv m5out fitness_out
mv *_out results_256kB_L2/

mkdir results_128kB_L2
./run_wearables128kB.sh urlparser  > /dev/null 2>&1 &
sleep 600
killall -2 gem5.opt
mv m5out parser_out
./run_wearables128kB.sh aes
mv m5out aes_out
./run_wearables128kB.sh astar
mv m5out astar_out
./run_wearables128kB.sh video  > /dev/null 2>&1 &
sleep 600
killall -2 gem5.opt
mv m5out video_out
./run_wearables128kB.sh fitness  > /dev/null 2>&1 &
sleep 600
killall -2 gem5.opt
mv m5out fitness_out
mv *_out results_128kB_L2/

mkdir results_no_L2
./run_wearablesnoL2.sh urlparser  > /dev/null 2>&1 &
sleep 600
killall -2 gem5.opt
mv m5out parser_out
./run_wearablesnoL2.sh aes
mv m5out aes_out
./run_wearablesnoL2.sh astar
mv m5out astar_out
./run_wearablesnoL2.sh video  > /dev/null 2>&1 &
sleep 600
killall -2 gem5.opt
mv m5out video_out
./run_wearablesnoL2.sh fitness  > /dev/null 2>&1 &
sleep 600
killall -2 gem5.opt
mv m5out fitness_out
mv *_out results_no_L2/

mkdir results_noCache
./run_wearablesnoCache.sh urlparser  > /dev/null 2>&1 &
sleep 600
killall -2 gem5.opt
mv m5out parser_out
./run_wearablesnoCache.sh aes
mv m5out aes_out
./run_wearablesnoCache.sh astar
mv m5out astar_out
./run_wearablesnoCache.sh video  > /dev/null 2>&1 &
sleep 600
killall -2 gem5.opt
mv m5out video_out
./run_wearablesnoCache.sh fitness  > /dev/null 2>&1 &
sleep 600
killall -2 gem5.opt
mv m5out fitness_out
mv *_out results_noCache/

#!/bin/bash

echo $(pwd)

mkdir results_512kB_L2
./run_wearables512kB.sh urlparser
sleep 600
killall -2 gem5.opt
mv ./m5out ./parser_out
./run_wearables512kB.sh aes
sleep 60
mv m5out aes_out
./run_wearables512kB.sh astar
sleep 60
mv m5out astar_out
./run_wearables512kB.sh video   
sleep 600
killall -2 gem5.opt
mv m5out video_out
./run_wearables512kB.sh fitness   
sleep 600
killall -2 gem5.opt
mv m5out fitness_out
mv *_out results_512kB_L2/

mkdir results_256kB_L2
./run_wearables256kB.sh urlparser   
sleep 600
killall -2 gem5.opt
mv m5out parser_out
./run_wearables256kB.sh aes
sleep 60
mv m5out aes_out
./run_wearables256kB.sh astar
sleep 60
mv m5out astar_out
./run_wearables256kB.sh video   
sleep 600
killall -2 gem5.opt
mv m5out video_out
./run_wearables256kB.sh fitness   
sleep 600
killall -2 gem5.opt
mv m5out fitness_out
mv *_out results_256kB_L2/

mkdir results_128kB_L2
./run_wearables128kB.sh urlparser   
sleep 600
killall -2 gem5.opt
mv m5out parser_out
./run_wearables128kB.sh aes
sleep 60
mv m5out aes_out
./run_wearables128kB.sh astar
sleep 60
mv m5out astar_out
./run_wearables128kB.sh video   
sleep 600
killall -2 gem5.opt
mv m5out video_out
./run_wearables128kB.sh fitness
sleep 600
killall -2 gem5.opt
mv m5out fitness_out
mv *_out results_128kB_L2/

mkdir results_no_L2
./run_wearablesnoL2.sh urlparser   
sleep 600
killall -2 gem5.opt
mv m5out parser_out
./run_wearablesnoL2.sh aes
sleep 60
mv m5out aes_out
./run_wearablesnoL2.sh astar
sleep 60
mv m5out astar_out
./run_wearablesnoL2.sh video   
sleep 600
killall -2 gem5.opt
mv m5out video_out
./run_wearablesnoL2.sh fitness   
sleep 600
killall -2 gem5.opt
mv m5out fitness_out
mv *_out results_no_L2/

mkdir results_noCache
./run_wearablesnoCache.sh urlparser   
sleep 600
killall -2 gem5.opt
mv m5out parser_out
./run_wearablesnoCache.sh aes
sleep 60
mv m5out aes_out
./run_wearablesnoCache.sh astar
sleep 60
mv m5out astar_out
./run_wearablesnoCache.sh video   
sleep 600
killall -2 gem5.opt
mv m5out video_out
./run_wearablesnoCache.sh fitness   
sleep 600
killall -2 gem5.opt
mv m5out fitness_out
mv *_out results_noCache/

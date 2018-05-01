#!/bin/bash

TLB=32TLB

mkdir results_512kB_L2_$TLB
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
mv *_out results_512kB_L2_$TLB/

mkdir results_noCache_$TLB
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
mv *_out results_noCache_$TLB/

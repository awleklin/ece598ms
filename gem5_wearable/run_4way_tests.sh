#!/bin/bash

echo $(pwd)

#mkdir results_128kB_4way_L2
#./run_wearables128kB_4way.sh urlparser
#sleep 600
#killall -2 gem5.opt
#mv ./m5out ./parser_out
#./run_wearables128kB_4way.sh aes
#sleep 60
#mv m5out aes_out
#./run_wearables128kB_4way.sh astar
#sleep 60
#mv m5out astar_out
#./run_wearables128kB_4way.sh video   
#sleep 600
#killall -2 gem5.opt
#mv m5out video_out
./run_wearables128kB_4way.sh fitness   
sleep 600
killall -2 gem5.opt
mv m5out fitness_out
mv *_out results_128kB_4way_L2/

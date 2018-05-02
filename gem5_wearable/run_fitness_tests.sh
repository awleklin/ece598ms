#!/bin/bash

./run_wearables512kB.sh fitness   
sleep 600
killall -2 gem5.opt
mv m5out fitness_out


#!/bin/bash

scons CPU_MODELS="AtomicSimpleCPU,MinorCPU,O3CPU,TimingSimpleCPU" build/ARM/gem5.opt -j8


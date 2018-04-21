build/ARM/gem5.fast -d m5out/step1 ./configs/example/se.py --caches --l2cache --cpu-type=O3_ARM_v7a_3 -c ../benchmark/microbench/Step1 -o '10'  >m5out/step1/run.log &
build/ARM/gem5.fast -d m5out/step2 ./configs/example/se.py --caches --l2cache --cpu-type=O3_ARM_v7a_3 -c ../benchmark/microbench/Step2 -o '9'   >m5out/step2/run.log &
build/ARM/gem5.fast -d m5out/step3 ./configs/example/se.py --caches --l2cache --cpu-type=O3_ARM_v7a_3 -c ../benchmark/microbench/Step3 -o '5 2' >m5out/step3/run.log &
build/ARM/gem5.fast -d m5out/step4 ./configs/example/se.py --caches --l2cache --cpu-type=O3_ARM_v7a_3 -c ../benchmark/microbench/Step4 -o '5 2' >m5out/step4/run.log &
build/ARM/gem5.fast -d m5out/step5 ./configs/example/se.py --caches --l2cache --cpu-type=O3_ARM_v7a_3 -c ../benchmark/microbench/Step5 -o '6'   >m5out/step5/run.log
build/ARM/gem5.fast -d m5out/step6 ./configs/example/se.py --caches --l2cache --cpu-type=O3_ARM_v7a_3 -c ../benchmark/microbench/Step6 -o '4'   >m5out/step6/run.log
build/ARM/gem5.fast -d m5out/step7 ./configs/example/se.py --caches --l2cache --cpu-type=O3_ARM_v7a_3 -c ../benchmark/microbench/Step7 -o '9'   >m5out/step7/run.log
build/ARM/gem5.fast -d m5out/step10 ./configs/example/se.py --caches --l2cache --cpu-type=O3_ARM_v7a_3 -c ../benchmark/microbench/Step10        >m5out/step10/run.log
sh rungem5.sh soplex
build/ARM/gem5.fast -d m5out/Bubblesort ./configs/example/se.py --caches --l2cache --cpu-type=O3_ARM_v7a_3 -c ../benchmark/se-benchmarks/Bubblesort &
build/ARM/gem5.fast -d m5out/Perm       ./configs/example/se.py --caches --l2cache --cpu-type=O3_ARM_v7a_3 -c ../benchmark/se-benchmarks/Perm &
build/ARM/gem5.fast -d m5out/Puzzle     ./configs/example/se.py --caches --l2cache --cpu-type=O3_ARM_v7a_3 -c ../benchmark/se-benchmarks/Puzzle
build/ARM/gem5.fast -d m5out/Quicksort  ./configs/example/se.py --caches --l2cache --cpu-type=O3_ARM_v7a_3 -c ../benchmark/se-benchmarks/Quicksort

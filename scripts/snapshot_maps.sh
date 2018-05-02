#!/bin/bash

# Author: Umur Darbaz
# A script to pause a process, snapshot its page mappings, and continue afterwards
# Last Modified: Feb 12, 2018
# Created: Feb 12, 2018

#if [ $CONTAINERS -eq "1" ]; then
#    docker pause $(docker ps -q | xargs docker inspect --format '{{.State.Pid}}, {{.ID}}' | grep "^${pid},")
#fi

CONTAINERS=0
PIDS=()

for i in "$@"
do
  case $i in 
    -c|--container)
    CONTAINERS=1
    ;;
    *)
    PIDS+=("$i")
    ;;
  esac
done

for pid in ${PIDS[@]}
do
  # Pause the process
  kill -SIGSTOP $pid

  # Snapshot application
  python get_maps.py $pid > ${pid}_maps_snapshot.txt

  # Continue the process
  kill -SIGCONT $pid
done


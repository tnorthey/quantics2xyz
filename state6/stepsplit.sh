#!/bin/bash

tail -n +2 $1 > file.tmp
awk -v RS='set title "Time' '{print > ("step-" NR ".txt")}' file.tmp
rm file.tmp

for i in step*txt
  do
  grep -Ev 'e|n' $i > ${i%.*}.dat
  done

rm step*txt

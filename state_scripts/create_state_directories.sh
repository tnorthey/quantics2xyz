#!/bin/bash

for i in *.pl
do
  mkdir ${i%.*}
  cp $i ${i%.*} 
  cp state_scripts/* ${i%.*}
done

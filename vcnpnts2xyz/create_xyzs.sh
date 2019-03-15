#!/bin/bash

for i in *vcpnts.inp
do
  vcpnt90 $i 
  cp tmp\ \ \ \ .com ${i%.*}.xyz
done

#!/bin/bash
c=0
while read p; do
  c=$(echo $c+1 | bc)
  x=$(echo $p | awk '{print $1}')
  y=$(echo $p | awk '{print $2}')
  sed "s/A/$x/" template.inp > ${c}_vcpnts.inp
  sed -i "s/B/$y/" ${c}_vcpnts.inp
  #echo $x
  #echo $y
done < ../grid.dat

#!/bin/bash

for i in step*.dat
do
  grep -Ev '000000000000|E-03|E-04|E-05|E-06|E-07|E-08|E-09|E-10|E-11' $i > ${i%.*}.nonzero
done

sed -i '/^\s*$/d' *nonzero


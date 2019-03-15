#!/bin/bash

for i in {1..8}
do 
  cd state${i}
  ./stepsplit.sh state${i}.pl
  ./onlynonzero.sh
  cd -
done


#!/bin/bash

for i in {1..8}
do
  grep "state = $i  pop" output | awk '{print $5}' > state${i}.pop
done


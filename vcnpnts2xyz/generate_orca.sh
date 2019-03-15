#!/bin/bash

for i in *vcpnts.xyz
do
  gs=${i%.*}_GS
  ct=${i%.*}_CT
  mkdir -p orca/$gs
  mkdir -p orca/$ct
  sed "s/file.xyz/$i/" GS_template.inp > orca/${gs}/${gs}.inp
  sed "s/file.xyz/$i/" CT_template.inp > orca/${ct}/${ct}.inp
  cp $i orca/${gs}/
  cp $i orca/${ct}/
done

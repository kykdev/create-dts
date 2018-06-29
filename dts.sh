#!/bin/bash

export RDIR=$(pwd)

for BOOTIMG in *.img; do
  [ -d "${BOOTIMG}.out" ] && echo "${BOOTIMG}.out already exists, skipping" && continue
  $RDIR/extract-dtb.py -o $RDIR/"${BOOTIMG}.out" $RDIR/"$BOOTIMG"
  
  for DTB in "${BOOTIMG}.out"/*.dtb; do
    $RDIR/dtc -I dtb -O dts -o "${DTB%.*}.dts" "$DTB"
  done
done

exit

#!/bin/bash

export RDIR=$(pwd)

for BOOTIMG in *.img; do
  [ -d "${BOOTIMG}.out" ] && echo "${BOOTIMG}.out already exists, skipping" && continue
  $RDIR/extract-dtb.py -o $RDIR/"${BOOTIMG}.out" $RDIR/"$BOOTIMG"
  
  for DTB in "${BOOTIMG}.out"/*dtbdump*; do
    $RDIR/dtc -I dtb -O dts -o "$(echo $DTB | sed -e "s/\.dtb/\.dts/")" "$DTB"
  done
done

exit

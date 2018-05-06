#!/bin/bash

for folder in *; do
  if [[ -d $folder ]]; then
    cd "$folder" || exit
    for subfolder in *; do
      if [[ -d "$subfolder" ]]; then
        cd "$subfolder" || exit
        ./*.sh
        cd ..
      fi
    done
    cd ..
  fi
done

#!/bin/bash

file_list=( ".tmux" )

for file in "${file_list[@]}"; do
    if [ -d "$file" ]; then
        echo "Updating submodule: $file"
        cd "$file" || exit
        git pull
        cd - || exit
    else
        echo "Submodule $file does not exist."
    fi
done

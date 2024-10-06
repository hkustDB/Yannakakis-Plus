#!/bin/bash

# Define source and destination directories
src_base="jobYa"
dst_base="job"

# Check if source and destination directories exist
if [ ! -d "$src_base" ]; then
    echo "Source directory $src_base does not exist."
    exit 1
fi

if [ ! -d "$dst_base" ]; then
    echo "Destination directory $dst_base does not exist."
    exit 1
fi

# Generate cp commands
for subdir in ${src_base}/*/; do
    subdir_name=$(basename "$subdir")
    src_path="${src_base}/${subdir_name}"
    dst_path="${dst_base}/${subdir_name}"

    if [ -d "$src_path" ] && [ -d "$dst_path" ]; then
        for file in ${src_path}/rewriteYa*.sql; do
            if [ -e "$file" ]; then
                echo "cp $file ${dst_path}/"
            fi
        done
    fi
done

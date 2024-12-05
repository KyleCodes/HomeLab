#!/bin/bash

# Navigate to the Movies directory relative to the script location
cd "$(dirname "$0")/Movies" || exit

# Iterate over all subdirectories in Movies
for directory in */; do
  echo "Checking directory: $directory"

  # Change into the directory containing the .rar files
  cd "$directory" || continue

  # Find .rar files in the current directory
  rar_files=(*.rar)
  if [ "${#rar_files[@]}" -eq 0 ]; then
    echo "No .rar files found in $directory, skipping."
    cd .. || exit
    continue
  fi

  # Extract each .rar file
  for rar_file in "${rar_files[@]}"; do
    echo "Extracting $rar_file..."
    unrar x -r -o- "$rar_file" "." # Extract without overwriting existing files
  done

  # Return to the parent directory
  cd .. || exit
done

echo "Extraction completed."

#
# for directory in ./Movies/*; do
#   cd "$directory"
#   pwd
#   unrar x -r -o- *.rar "$directory"
# done
#

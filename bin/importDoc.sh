#!/bin/bash

# Directory where your downloads are stored (change if necessary)
download_dir="$HOME/Downloads"

# Get the most recently downloaded file
latest_file=$(ls -t "$download_dir" | head -n 1)

# Move the file to the current directory
mv "$download_dir/$latest_file" .

echo "Moved $latest_file to the current directory."


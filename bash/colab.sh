#!/bin/bash

# Get the current directory name
current_dir=$(basename "$(pwd)")

# Display the current directory name
echo "Current Directory: $current_dir"
echo

# List files in the current directory in long format
ls -l

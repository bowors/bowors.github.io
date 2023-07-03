#!/bin/bash

# colab user directory 
colab_home="/content"

rm -rf "$colab_home/sample_data"


# sleep for 2 seconds before starting
sleep 2

# # function to install dependencies
# install_dependency() {
#   local dependencies=("$@")

#   # function to check if a command exists
#   command_exists() {
#     command -v "$1" >/dev/null 2>&1
#   }

#   # array to hold packages that need to be installed
#   local packages_to_install=()

#   # loop through each dependency
#   for dependency in "${dependencies[@]}"; do
#     # split the dependency into command name and package name
#     IFS=":" read -r command_name package_name <<< "$dependency"

#     # if package name is not provided, use command name as the package name
#     if [ -z "$package_name" ]; then
#       package_name="$command_name"
#     fi

#     # check if the command is already installed
#     if command_exists "$command_name"; then
#       echo "$command_name is already installed. ✅"
#     else
#       echo "$command_name is not installed. Proceeding with installation..."
#       packages_to_install+=("$package_name")
#     fi
#   done

#   # update package list and install all packages at once using apt-get
#   if [ ${#packages_to_install[@]} -ne 0 ]; then
#     apt-get update >/dev/null
#     if apt-get install -y "${packages_to_install[@]}" >/dev/null; then
#       echo "All packages installed successfully. ✅"
#     else
#       echo "Failed to install some packages. ❌"
#     fi
#   fi
# }

# # Define the dependencies to install
# DEPENDENCIES=("jq" "aria2c:aria2")
# # Install the dependencies
# install_dependency "${DEPENDENCIES[@]}"

colab_home="/content"

# function to download a repository
download_repo() {
  local repo_url="$1"
  local repo_cmd=("${@:2}")

  repo_dir="$colab_home/$(basename $1 | sed 's/\.git$//')"

  # remove existing directory if it exists
  if [ -d "$repo_dir" ]; then
    echo "removing existing directory..."
    rm -rf "$repo_dir"||{ echo "failed to remove directory. ❌"; return 1; }
    echo "existing directory removed. ✅"
  fi

  echo "cloning the repository..."
  # clone the repository using git
  git clone --depth 1 -q "$repo_url" "$repo_dir"||{ echo "failed to clone repository. ❌"; return 1; }
  echo "repository cloned successfully. ✅"

  if [ ! -z "${repo_cmd}" ]; then
    echo "executing commands..."
    # execute additional commands provided for the repository
    printf '%s\n' "${repo_cmd[@]}" | xargs -I {} -P $(nproc) sh -c '{}'
    echo "command execution completed. ✅"
  fi
}

# Define the repository URL and directory for the text generation
download_repo "https://github.com/oobabooga/text-generation-webui.git"

# # function to download model files
# download_model() {
#   local model="$1"
#   ifs="/" read -r owner name <<< "$model"
#   local model_url="https://huggingface.co/api/models/${model}"
#   local model_link="https://huggingface.co/${model}/resolve/main/"
#   local model_dir="/content/text-generation-webui/models/${owner}_${name}"

#   echo "downloading files from the repository..."
#   # use curl and jq to retrieve file names from the model repository
#   # then use aria2c to download the files in parallel
#   if ! curl -s "$model_url" |
#   jq -r '.siblings[] | select(.rfilename) | .rfilename' |
#   while read -r filename; do
#     echo "$model_link$filename $filename"
#   done |
#   awk '{print $1, "--out=" $2}' |
#   xargs -n 2 aria2c \
#   --console-log-level=warn \
#   --continue \
#   --max-concurrent-downloads=16 \
#   --max-connection-per-server=16 \
#   --min-split-size=8m \
#   --split=16 \
#   --summary-interval=0 \
#   -d "$model_dir" \
#   >/dev/null 2>&1; then
#     echo "failed to download files from the repository. ❌"
#     return 1
#   fi
#   echo "file download completed. ✅"
# }
# 
# Define the model to download
# MODEL="jondurbin/airoboros-7b-ggml-q4_0"




# Download the model files
# download_model "$MODEL"

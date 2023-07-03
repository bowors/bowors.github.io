#!/bin/bash

REPO="askmyteapot/metharme"
IFS="/" read -r OWNER MODEL <<< "$REPO"
REPO_URL="https://huggingface.co/api/${REPO}"
DOWNLOAD_URL="https://huggingface.co/${REPO}/resolve/main/"
OUTPUT_DIR="/content/text-generation-webui/models/${OWNER}_${MODEL}"

curl -s "$REPO_URL" | jq -r '.siblings[] | select(.rfilename) | .rfilename' | while read -r FILENAME; do
    echo "$DOWNLOAD_URL$FILENAME $FILENAME"
done | awk '{print $1, "--out=" $2}' | \
xargs -n 2 aria2c --summary-interval=10 -c -s 10 --max-concurrent-downloads=10 \
--max-connection-per-server=16 -d "$OUTPUT_DIR"


how to do string interpolate in bash if i want to replace
"/askmyteapot/metharme"


how to split example string like : "askmyteapot/metharme" 
into variable like this, in bash.
example
owner = askmyteapot
model = metharme 

REPO="askmyteapot/metharme"; IFS="/" read -r OWNER MODEL <<< "$REPO"; REPO_URL="https://huggingface.co/api/${REPO}"; DOWNLOAD_URL="https://huggingface.co/${REPO}/resolve/main/"; OUTPUT_DIR="/content/text-generation-webui/models/${OWNER}_${MODEL}"; echo "$REPO"; echo "$OWNER"; echo "$MODEL"; echo "$REPO_URL"; echo "$DOWNLOAD_URL"; echo "$OUTPUT_DIR"

#!/bin/bash

# This script downloads models from the Hugging Face Model Hub using the given repository URL.

REPO="askmyteapot/metharme"  # Specify the repository in the format owner/model
IFS="/" read -r OWNER MODEL <<< "$REPO"  # Extract the owner and model name from the repository URL
REPO_URL="https://huggingface.co/api/${REPO}"  # Construct the API URL for the repository
DOWNLOAD_URL="https://huggingface.co/${REPO}/resolve/main/"  # Construct the download URL for the repository
OUTPUT_DIR="/content/text-generation-webui/models/${OWNER}_${MODEL}"  # Specify the output directory for downloaded models

# Use curl and jq to get a list of available model files in the repository and iterate over them
curl -s "$REPO_URL" | jq -r '.siblings[] | select(.rfilename) | .rfilename' | while read -r FILENAME; do
    echo "$DOWNLOAD_URL$FILENAME $FILENAME"  # Print the download URL and filename
done | awk '{print $1, "--out=" $2}' | \
xargs -n 2 aria2c --summary-interval=10 -c -s 10 --max-concurrent-downloads=10 \
--max-connection-per-server=16 -d "$OUTPUT_DIR"  # Use aria2c to download the files to the specified output directory

# Add your comment here to provide more context or additional information about the script.






#!/bin/bash
if ! command -v jq &> /dev/null; then
    echo "jq is not installed. Proceeding with installation..."
    apt-get install jq -y > /dev/null
    echo "jq installed successfully."
else
    echo "jq is already installed."
fi

# Check if aria2 is installed
if ! command -v aria2c &> /dev/null; then
    echo "aria2 is not installed. Proceeding with installation..."
    apt-get install aria2 -y > /dev/null
    echo "aria2 installed successfully."
else
    echo "aria2 is already installed."
fi

cd /
if [ -d "/content/text-generation-webui/" ]; then
  rm -r "/content/text-generation-webui/"
fi

git clone https://github.com/oobabooga/text-generation-webui.git

REPO="askmyteapot/metharme"
IFS="/" read -r OWNER MODEL <<< "$REPO"
REPO_URL="https://huggingface.co/api/models/${REPO}"
DOWNLOAD_URL="https://huggingface.co/${REPO}/resolve/main/"
OUTPUT_DIR="/content/text-generation-webui/models/${OWNER}_${MODEL}"


curl -s "$REPO_URL" |
  jq -r '.siblings[] | select(.rfilename) | .rfilename' |
  while read -r FILENAME; do
    echo "$DOWNLOAD_URL$FILENAME $FILENAME"
  done |
  awk '{print $1, "--out=" $2}' |
  xargs -n 2 aria2c \
    --show-console-readout=false \
    --console-log-level=warn \
    --summary-interval=5 \
    -c -s 10 \
    --max-concurrent-downloads=16 \
    --max-connection-per-server=16 \
    -d "$OUTPUT_DIR"
#!/bin/bash
# This line specifies that the script should be executed using the bash shell.

# Display NVIDIA GPU information
nvidia-smi
# This command displays information about the NVIDIA GPU.

# Clone the GitHub repository for text generation web UI
git clone https://github.com/oobabooga/text-generation-webui
# This command clones the specified GitHub repository to the current directory.

# Create a directory for the Pygmalion-7b-Merged-Safetensors model
mkdir /content/text-generation-webui/models/Pygmalion-7b-Merged-Safetensors
# This command creates a new directory at the specified path.

# Specify the URLs for the files to be downloaded and pass them to aria2c for parallel downloading
echo "https://huggingface.co/TehVenom/Pygmalion-7b-Merged-Safetensors/resolve/main/config.json
https://huggingface.co/TehVenom/Pygmalion-7b-Merged-Safetensors/resolve/main/generation_config.json
https://huggingface.co/TehVenom/Pygmalion-7b-Merged-Safetensors/resolve/main/model-00001-of-00007.safetensors
https://huggingface.co/TehVenom/Pygmalion-7b-Merged-Safetensors/resolve/main/model-00002-of-00007.safetensors
https://huggingface.co/TehVenom/Pygmalion-7b-Merged-Safetensors/resolve/main/model-00003-of-00007.safetensors
https://huggingface.co/TehVenom/Pygmalion-7b-Merged-Safetensors/resolve/main/model-00004-of-00007.safetensors
https://huggingface.co/TehVenom/Pygmalion-7b-Merged-Safetensors/resolve/main/model-00005-of-00007.safetensors
https://huggingface.co/TehVenom/Pygmalion-7b-Merged-Safetensors/resolve/main/model-00006-of-00007.safetensors
https://huggingface.co/TehVenom/Pygmalion-7b-Merged-Safetensors/resolve/main/model-00007-of-00007.safetensors
https://huggingface.co/TehVenom/Pygmalion-7b-Merged-Safetensors/resolve/main/model.safetensors.index.json
https://huggingface.co/TehVenom/Pygmalion-7b-Merged-Safetensors/resolve/main/special_tokens_map.json
https://huggingface.co/TehVenom/Pygmalion-7b-Merged-Safetensors/resolve/main/tokenizer.json
https://huggingface.co/TehVenom/Pygmalion-7b-Merged-Safetensors/resolve/main/tokenizer.model
https://huggingface.co/TehVenom/Pygmalion-7b-Merged-Safetensors/resolve/main/tokenizer_config.json" | xargs -n 1 aria2c -x 16 -s 16 --max-connection-per-server=16 --split=16 --min-split-size=1M --max-overall-download-limit=0 --max-download-limit=0 --auto-file-renaming=false -d /content/text-generation-webui/models/Pygmalion-7b-Merged-Safetensors
# This command uses echo to print the URLs, pipes them to xargs to pass each URL as an argument to aria2c, and downloads the files using specified options.

# Install the required Python packages from the requirements.txt file
pip install -r requirements.txt
# This command installs the Python packages listed in the requirements.txt file.

# Change the current directory to text-generation-webui
cd text-generation-webui
# This command changes the current directory to the specified directory.

# Start the server by running server.py and enable sharing
python server.py --share --api --public-api
# This command starts the server by running the server.py script with specified options.


#!/bin/bash
# Display NVIDIA GPU information
nvidia-smi

# Clone the GitHub repository for text generation web UI
git clone https://github.com/oobabooga/text-generation-webui

# Change the current directory to text-generation-webui
cd text-generation-webui

# Install the required Python packages from the requirements.txt file
pip install -r requirements.txt

# Download the pre-trained model for text generation
#python download-model.py TehVenom/Pygmalion-13b-Merged

# Start the server by running server.py and enable sharing
python server.py --share --api

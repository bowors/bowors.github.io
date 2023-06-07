#!/bin/bash

LOG_FILE="script.log"

# Function to log messages to the log file
log() {
  echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Display NVIDIA GPU information
nvidia-smi

# Clone the GitHub repository for text generation web UI if it doesn't exist
if [ ! -d "text-generation-webui" ]; then
  log "Cloning text-generation-webui repository..."
  git clone https://github.com/oobabooga/text-generation-webui || { log "Error: Failed to clone repository."; exit 1; }
fi

# Change the current directory to text-generation-webui
log "Changing directory to text-generation-webui..."
cd text-generation-webui || { log "Error: Failed to change directory."; exit 1; }

# Install the required Python packages from the requirements.txt file if not already installed
log "Installing Python dependencies..."
if ! command -v pip >/dev/null 2>&1; then
  log "Error: pip command not found."; exit 1;
fi

if [ ! -f "requirements.txt" ]; then
  log "Error: requirements.txt file not found."; exit 1;
fi

pip install -r requirements.txt || { log "Error: Failed to install Python dependencies."; exit 1; }

# Download the pre-trained model for text generation if not already downloaded
log "Downloading pre-trained model..."
python download-model.py TehVenom/Pygmalion-13b-Merged || { log "Error: Failed to download pre-trained model."; exit 1; }

# Start the server by running server.py and enable sharing
log "Starting the server..."
nohup python server.py --share --api >> "$LOG_FILE" 2>&1 &
log "Server started. Check $LOG_FILE for server logs."


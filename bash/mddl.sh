#!/bin/bash
apt-get install aria2
cd /content/drive/MyDrive/model 
rm -r*
mkdir Pygmalion-7b-Merged-Safetensors
cd Pygmalion-7b-Merged-Safetensors

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
https://huggingface.co/TehVenom/Pygmalion-7b-Merged-Safetensors/resolve/main/tokenizer_config.json" | xargs -n 1 aria2c -x 16 -s 16 --max-connection-per-server=16 --split=16 --min-split-size=1M --max-overall-download-limit=0 --max-download-limit=0 -d /content/drive/MyDrive/model/Pygmalion-7b-Merged-Safetensors
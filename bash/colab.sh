#!/bin/bash
# Display NVIDIA GPU information
#nvidia-smi

# Clone the GitHub repository for text generation web UI
#git clone https://github.com/oobabooga/text-generation-webui

# Change the current directory to text-generation-webui
#cd text-generation-webui

# Install the required Python packages from the requirements.txt file
#pip install -r requirements.txt

# Download the pre-trained model for text generation
#python download-model.py TehVenom/Pygmalion-13b-Merged

# Start the server by running server.py and enable sharing
#python server.py --share --api



#xxxx/bin/bash
# KoboldAI Easy Colab Deployment Script by Henk717

# read the options
TEMP=`getopt -o m:i:p:c:d:x:a:l:z:g:t:n:b:s:r: --long model:,init:,path:,configname:,download:,aria2:,dloc:,xloc:,7z:,git:,tar:,ngrok:,branch:,savemodel:,localtunnel:,lt:,revision: -- "$@"`
eval set -- "$TEMP"

# extract options and their arguments into variables.
while true ; do
    case "$1" in
        -m|--model)
            model=" --model $2" ; shift 2 ;;
        -r|--revision)
            revision=" --revision $2" ; shift 2 ;;
        -i|--init)
            init=$2 ; shift 2 ;;
        -p|--path)
            mpath="$2" ; shift 2 ;;
        -c|--configname)
            configname=" --configname $2" ; shift 2 ;;
        -n|--ngrok)
            ngrok=" --ngrok" ; shift 2 ;;
        --lt|--localtunnel)
            localtunnel=" --localtunnel" ; shift 2 ;;
        -d|--download)
            download="$2" ; shift 2 ;;
        -a|--aria2)
            aria2="$2" ; shift 2 ;;
        -l|--dloc)
            dloc="$2" ; shift 2 ;;
        -x|--xloc)
            xloc="$2" ; shift 2 ;;
        -z|--7z)
            z7="$2" ; shift 2 ;;
        -t|--tar)
            tar="$2" ; shift 2 ;;
        -g|--git)
            git="$2" ; shift 2 ;;
        -b|--branch)
            branch="$2" ; shift 2 ;;
        -s|--savemodel)
            savemodel=" --savemodel" ; shift 2 ;;
        --) shift ; break ;;
        *) echo "Internal error!" ; exit 1 ;;
    esac
done

set | column -t

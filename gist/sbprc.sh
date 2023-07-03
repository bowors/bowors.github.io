#!/bin/bash

# Check if the keys directory is present
if [[ ! -d /content/drive/MyDrive/keys ]]; then
    echo "Error: keys directory not found"
    exit 1
fi

# Check if Flask is already installed and install it if not
if ! python3 -c "import flask" &> /dev/null; then
    pip install flask
fi

# Create .ssh directory and copy keys into it
mkdir ~/.ssh
cp /content/drive/MyDrive/keys/* ~/.ssh

# Create a named pipe for communication between processes
if [[ -e mypipe ]]; then
    rm mypipe
fi
mkfifo mypipe

# Define HTML content as a separate bash variable
html_content=$(cat <<'END'
<!DOCTYPE html>
<html>
  <head>
    <title>Send POST Request</title>
  </head>
  <body>
    <h1>Send a POST Request</h1>
    <button class="sendPostButton" data-id="1">
      Send POST Request 1
    </button>
    <button class="sendPostButton" data-id="2">
      Send POST Request 2
    </button>
    <button class="sendPostButton" data-id="3">
      Send POST Request 3
    </button>

    <script>
      const sendPostRequest = (id) => {
        const data = { key1: 'value1', key2: 'value2' };

        fetch(`/hook/${id}`, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(data)
        })
          .then(response => {
            if (response.ok) {
              return response.text();
            }
            throw new Error('Failed to send POST request');
          })
          .then(responseText => {
            console.log(responseText);
          })
          .catch(error => {
            console.log(error);
          });
      };

      const buttons = Array.from(
        document.getElementsByClassName('sendPostButton')
      );
      buttons.forEach(button => {
        const id = button.getAttribute('data-id');
        button.addEventListener('click', () => sendPostRequest(id));
      });
    </script>
  </body>
</html>

END
)

# Define Flask web server code as a string
flask_app=$(cat <<END
from flask import Flask, request
import json
import sys

html_content = sys.argv[1]

app = Flask(__name__)

@app.route('/', methods=['GET'])
def home():
     return f"{html_content}"

@app.route('/hook/<int:hook_id>', methods=['POST'])
def index(hook_id):
    # Notify process 2 by writing to the named pipe
    with open('mypipe', 'w') as f:
        f.write(f"request received from /hook/{hook_id}\n")
    # Format JSON output nicely and print it
    try:
        data = json.loads(request.data)
        print(json.dumps(data, indent=4))
    except:
        print(request.data)
    
    return 'Hello world'

if __name__ == '__main__':
    app.run(port=5150)
END
)

# Define process 1: Run the Flask web server
process1() {
    python3 -c "$flask_app" "$html_content"
}

# Define process 2: Keep track of subprocesses and download file when notified by process 1
process2() {
    pids=()
    while true; do
        read line < mypipe
        if [[ $line == "request received from /hook/"* ]]; then
            for pid in "${pids[@]}"; do
                kill $pid 2> /dev/null
            done
            pids=()
        fi
        case $line in
            "request received from /hook/1")
                wget -qO- https://example.com >&2 || \
                echo "Error: wget command failed" &
                pids+=($!)
                ;;
            "request received from /hook/2")
                wget -qO- https://google.com >&2 || \
                echo "Error: wget command failed" &
                pids+=($!)
                ;;
            "request received from /hook/3")
                wget -qO- https://bing.com >&2 || \
                echo "Error: wget command failed" &
                pids+=($!)
                ;;
        esac
    done
}

# Define process 3: Expose the web server to the internet using serveo
process3() {
    ssh -T -o StrictHostKeyChecking=no \
        -R pingin-ngepot:80:localhost:5150 serveo.net || \
        echo "Error: ssh command failed"
}

# Start all three processes in the background in numerical order
process1 &
process2 &
process3 &

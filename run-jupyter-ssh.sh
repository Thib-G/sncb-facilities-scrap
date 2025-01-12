#!/bin/bash

# Define variables
SSH_HOST="linked-data.goelff.be"       # Replace with the SSH server address
REMOTE_SCRIPT="cd ~/sncb-facilities-scrap; source .venv/bin/activate; jupyter lab --no-browser --port=8888"
LOCAL_PORT=8888

# Check if a local tunnel is already running
if lsof -i :$LOCAL_PORT | grep -q LISTEN; then
    echo "A Jupyter server is already running locally on port $LOCAL_PORT."
    echo "Open http://localhost:$LOCAL_PORT in your browser."
    exit 0
fi

# Start the SSH tunnel and Jupyter server
echo "Starting SSH tunnel and Jupyter server..."
ssh -L $LOCAL_PORT:127.0.0.1:$LOCAL_PORT $SSH_HOST "$REMOTE_SCRIPT" &

# Wait a moment to ensure the server starts
sleep 5

# Open Jupyter Lab in the default browser
if which xdg-open > /dev/null; then
    xdg-open "http://localhost:$LOCAL_PORT"
elif which open > /dev/null; then
    open "http://localhost:$LOCAL_PORT"
else
    echo "Jupyter Lab is running. Open http://localhost:$LOCAL_PORT in your browser."
fi

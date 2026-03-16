#!/bin/bash

set -e
if [ ! -f "requirements.txt" ]; then
    echo "requirements not found"
    exit 1
fi
VENV_DIR=".venv"
if [ ! -d "$VENV_DIR" ]; then
    python3 -m venv "$VENV_DIR"
fi
source "$VENV_DIR/bin/activate"

pip install --upgrade pip
echo "installing dependencies"
pip install -r requirements.txt

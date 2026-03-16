#!/bin/bash

PROJECT_DIR="$HOME/.local/share/translate"
VENV_PYTHON="$PROJECT_DIR/.venv/bin/python"
PORT=55000

pkill -f "ghost_trans.py" || true

if ! nc -z localhost $PORT; then
    nohup $VENV_PYTHON -m uvicorn server:app \
        --app-dir "$PROJECT_DIR" \
        --host 0.0.0.0 \
        --port $PORT > /dev/null 2>&1 &
    sleep 3
fi

$VENV_PYTHON "$PROJECT_DIR/ghost_trans.py"

#!/usr/bin/env bash
# Run Card Conjurer locally (no Docker required)
set -e

PORT="${PORT:-4242}"
HOST="${HOST:-127.0.0.1}"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Starting Card Conjurer on http://${HOST}:${PORT}/"
echo "(Open the root URL, then click 'Card Creator' in the menu)"
echo "Press Ctrl+C to stop."

# Check if port is already in use
if command -v ss &>/dev/null; then
    PID=$(ss -tlnp "sport = :$PORT" 2>/dev/null | grep -oP 'pid=\K\d+' | head -1)
elif command -v lsof &>/dev/null; then
    PID=$(lsof -ti :"$PORT" 2>/dev/null | head -1)
fi

if [ -n "$PID" ]; then
    echo "Warning: Port $PORT is already in use by process(es): $PID"
    echo "To fix, run: kill $PID"
fi

# Try Node.js serve first (more robust for large files), fallback to Python
if command -v node &>/dev/null; then
    cd "$SCRIPT_DIR" && npx -y serve -l "$PORT" .
elif command -v python3 &>/dev/null; then
    cd "$SCRIPT_DIR" && python3 -m http.server "$PORT" --bind "$HOST" 2>&1 || true
else
    echo "Error: Need Python 3 or Node.js installed."
    exit 1
fi

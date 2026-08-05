#!/usr/bin/env bash
# Run Card Conjurer locally (no Docker required)
set -e

PORT="${PORT:-4242}"
HOST="${HOST:-127.0.0.1}"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Starting Card Conjurer on http://${HOST}:${PORT}/creator/index.html"
echo "Press Ctrl+C to stop."

# Try Python 3 first, then fall back to Node.js, then plain Python
if command -v python3 &>/dev/null; then
    cd "$SCRIPT_DIR" && python3 -m http.server "$PORT" --bind "$HOST"
elif command -v node &>/dev/null; then
    cd "$SCRIPT_DIR" && npx -y serve -l "$PORT" -s .
else
    echo "Error: Need Python 3 or Node.js installed."
    exit 1
fi

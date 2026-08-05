#!/usr/bin/env bash
# Run Card Conjurer locally (no Docker required)
set -e

PORT="${PORT:-4242}"
HOST="${HOST:-127.0.0.1}"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Starting Card Conjurer on http://${HOST}:${PORT}/"
echo "(Open the root URL, then click 'Card Creator' in the menu)"
echo "Press Ctrl+C to stop."

# Prefer Node.js serve (handles connection aborts gracefully)
if command -v node &>/dev/null; then
    cd "$SCRIPT_DIR" && npx -y serve -l "$PORT" -s .
elif command -v python3 &>/dev/null; then
    # Python's http.server throws on aborted connections — suppress the noise
    cd "$SCRIPT_DIR" && python3 -m http.server "$PORT" --bind "$HOST" 2> >(grep -vi "connectionabortederror\|established connection was aborted" >&2)
else
    echo "Error: Need Python 3 or Node.js installed."
    exit 1
fi

#!/usr/bin/env bash
# Build Card Conjurer Docker image (optional — only needed for Docker deployment)
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
IMAGE_NAME="${IMAGE_NAME:-cardconjurer-client}"
TAG="${TAG:-latest}"

echo "Building Docker image: ${IMAGE_NAME}:${TAG}"
docker build -f "$SCRIPT_DIR/Dockerfile" --target prod "$SCRIPT_DIR" -t "${IMAGE_NAME}:${TAG}"

echo ""
echo "Build complete. Run with:"
echo "  docker run -dit -h 127.0.0.1 -p 4242:4242 ${IMAGE_NAME}:${TAG}"
echo ""
echo "Or use the quick-run script instead (no Docker needed):"
echo "  ./run.sh"

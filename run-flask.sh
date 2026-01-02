#!/bin/bash

# Simple script to run the Flask app locally

set -e

IMAGE_NAME="gitops-app"
CONTAINER_NAME="gitops-app-flask"
PORT=${1:-5000}  # Use first argument or default to 5000

echo "Stopping any existing Flask containers..."
docker stop ${CONTAINER_NAME} 2>/dev/null || true
docker rm ${CONTAINER_NAME} 2>/dev/null || true

echo "Building Flask app..."
docker build -t ${IMAGE_NAME}:latest .

echo "Running Flask app on port ${PORT}..."
docker run -d --name ${CONTAINER_NAME} -p ${PORT}:5000 ${IMAGE_NAME}:latest

echo ""
echo "✓ Flask app is running!"
echo "  Access at: http://localhost:${PORT}"
echo "  Health check: http://localhost:${PORT}/health"
echo ""
echo "To view logs: docker logs ${CONTAINER_NAME}"
echo "To stop: docker stop ${CONTAINER_NAME}"


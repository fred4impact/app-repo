#!/bin/bash

# Docker Build, Run, Tag, and Push Script
# Usage: ./build-and-push.sh [docker-hub-username] [image-name] [tag]

set -e  # Exit on error

# Configuration
DOCKER_HUB_USERNAME=${1:-"your-dockerhub-username"}  # First argument or default
IMAGE_NAME=${2:-"gitops-app"}  # Second argument or default image name
TAG=${3:-"latest"}  # Third argument or default tag
FULL_IMAGE_NAME="${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:${TAG}"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Docker Build and Push Script ===${NC}"
echo -e "Docker Hub Username: ${YELLOW}${DOCKER_HUB_USERNAME}${NC}"
echo -e "Image Name: ${YELLOW}${IMAGE_NAME}${NC}"
echo -e "Tag: ${YELLOW}${TAG}${NC}"
echo -e "Full Image: ${YELLOW}${FULL_IMAGE_NAME}${NC}"
echo ""

# Step 1: Build the Docker image
echo -e "${BLUE}[1/4] Building Docker image...${NC}"
docker build -t ${IMAGE_NAME}:${TAG} .
echo -e "${GREEN}✓ Build complete${NC}"
echo ""

# Step 2: Tag the image for Docker Hub
echo -e "${BLUE}[2/4] Tagging image for Docker Hub...${NC}"
docker tag ${IMAGE_NAME}:${TAG} ${FULL_IMAGE_NAME}
echo -e "${GREEN}✓ Image tagged as ${FULL_IMAGE_NAME}${NC}"
echo ""

# Step 3: Run the container locally
echo -e "${BLUE}[3/4] Running container locally...${NC}"
# Stop and remove existing container if it exists
docker stop ${IMAGE_NAME}-local 2>/dev/null || true
docker rm ${IMAGE_NAME}-local 2>/dev/null || true

# Run the container in detached mode
docker run -d --name ${IMAGE_NAME}-local -p 5000:5000 ${IMAGE_NAME}:${TAG}
echo -e "${GREEN}✓ Container running locally on port 5000${NC}"
echo -e "${YELLOW}  Access it at: http://localhost:5000${NC}"
echo -e "${YELLOW}  To stop: docker stop ${IMAGE_NAME}-local${NC}"
echo -e "${YELLOW}  To view logs: docker logs ${IMAGE_NAME}-local${NC}"
echo ""

# Step 4: Push to Docker Hub
echo -e "${BLUE}[4/4] Pushing to Docker Hub...${NC}"
echo -e "${YELLOW}Make sure you're logged in to Docker Hub (docker login)${NC}"
read -p "Press Enter to continue with push, or Ctrl+C to cancel..."
docker push ${FULL_IMAGE_NAME}
echo -e "${GREEN}✓ Image pushed to Docker Hub${NC}"
echo ""

echo -e "${GREEN}=== All steps completed successfully! ===${NC}"
echo -e "Image available at: ${YELLOW}${FULL_IMAGE_NAME}${NC}"


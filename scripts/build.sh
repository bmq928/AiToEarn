#!/bin/bash
# 构建所有服务的 Docker 镜像（本地构建，不推送）
# Build all service Docker images (local build, no push)
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "=== Preparing backend build contexts ==="
"$PROJECT_ROOT/scripts/prepare-docker-contexts.sh"

echo ""
echo "=== Building all service images via docker compose ==="
cd "$PROJECT_ROOT"
docker compose build

echo ""
echo "=== All images built successfully ==="
echo ""
docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}" | grep -E "aitoearn|REPOSITORY"
echo ""
echo "Run 'docker compose up -d' to start all services with local images."

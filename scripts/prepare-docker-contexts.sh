#!/bin/bash
# 准备后端服务的 Docker 构建上下文（供 docker compose build 本地构建使用）
# Prepare backend Docker build contexts (for local build via docker compose build)
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
BACKEND_DIR="$PROJECT_ROOT/project/aitoearn-backend"

cd "$BACKEND_DIR"

echo "=== Preparing aitoearn-server docker context ==="
node scripts/build-docker.mjs aitoearn-server --context-only -o tmp/docker-context-aitoearn-server

echo "=== Preparing aitoearn-ai docker context ==="
node scripts/build-docker.mjs aitoearn-ai --context-only -o tmp/docker-context-aitoearn-ai

echo ""
echo "=== Backend docker contexts prepared ==="
echo "Run 'docker compose up -d --build' to build images from local source."

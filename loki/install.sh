#!/bin/bash
set -euo pipefail

VERSION="${LOKI_VERSION:-6.53.0}"

echo "Installing Grafana Loki (chart ${VERSION})..."

helm repo add grafana https://grafana.github.io/helm-charts 2>/dev/null || true
helm repo update grafana

helm upgrade --install loki grafana/loki \
  --namespace loki --create-namespace \
  --version "${VERSION}" \
  --set deploymentMode=SingleBinary \
  --set loki.auth_enabled=false \
  --set loki.commonConfig.replication_factor=1 \
  --set loki.storage.type=filesystem \
  --set singleBinary.replicas=1 \
  --set backend.replicas=0 \
  --set read.replicas=0 \
  --set write.replicas=0 \
  --set chunksCache.enabled=false \
  --set resultsCache.enabled=false \
  --wait --timeout 300s

echo "Loki installed successfully"
echo ""
echo "To send logs, install Promtail or Grafana Alloy pointing to:"
echo "  http://loki.loki.svc.cluster.local:3100"

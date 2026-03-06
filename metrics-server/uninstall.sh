#!/bin/bash
set -euo pipefail

VERSION="${METRICS_SERVER_VERSION:-v0.7.2}"
MANIFEST_URL="https://github.com/kubernetes-sigs/metrics-server/releases/download/${VERSION}/components.yaml"

echo "Uninstalling metrics-server..."
kubectl delete -f "${MANIFEST_URL}" --ignore-not-found

echo "metrics-server removed"

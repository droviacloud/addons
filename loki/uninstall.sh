#!/bin/bash
set -euo pipefail

echo "Uninstalling Loki..."

helm uninstall loki --namespace loki 2>/dev/null || true
kubectl delete namespace loki --ignore-not-found

echo "Loki removed"

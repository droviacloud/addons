#!/bin/bash
set -euo pipefail

VERSION="${KYVERNO_VERSION:-3.7.1}"

echo "Installing Kyverno (chart ${VERSION})..."

helm repo add kyverno https://kyverno.github.io/kyverno/ 2>/dev/null || true
helm repo update kyverno

helm upgrade --install kyverno kyverno/kyverno \
  --namespace kyverno --create-namespace \
  --version "${VERSION}" \
  --wait --timeout 300s

echo "Kyverno installed successfully"

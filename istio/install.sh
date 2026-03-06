#!/bin/bash
set -euo pipefail

VERSION="${ISTIO_VERSION:-1.25.4}"

echo "Installing Istio ${VERSION}..."

helm repo add istio https://istio-release.storage.googleapis.com/charts 2>/dev/null || true
helm repo update istio

# 1. Base CRDs
helm upgrade --install istio-base istio/base \
  --namespace istio-system --create-namespace \
  --version "${VERSION}" \
  --wait

# 2. Istiod (control plane)
helm upgrade --install istiod istio/istiod \
  --namespace istio-system \
  --version "${VERSION}" \
  --wait --timeout 300s

# 3. Ingress Gateway (optional, enabled by default)
if [ "${ISTIO_INGRESS_ENABLED:-true}" = "true" ]; then
  helm upgrade --install istio-ingress istio/gateway \
    --namespace istio-ingress --create-namespace \
    --version "${VERSION}" \
    --wait
fi

echo "Istio ${VERSION} installed successfully"

#!/bin/bash
set -euo pipefail

VERSION="${INGRESS_NGINX_VERSION:-v1.12.1}"
MANIFEST_URL="https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-${VERSION}/deploy/static/provider/cloud/deploy.yaml"

echo "Installing ingress-nginx ${VERSION}..."
kubectl apply -f "${MANIFEST_URL}"

# Patch externalTrafficPolicy for clusters where external IP is on the control plane
echo "Patching ingress-nginx-controller service..."
kubectl -n ingress-nginx patch svc ingress-nginx-controller \
  -p '{"spec":{"externalTrafficPolicy":"Cluster"}}' 2>/dev/null || true

echo "Waiting for ingress-nginx to be ready..."
kubectl -n ingress-nginx rollout status deployment/ingress-nginx-controller --timeout=120s

echo "ingress-nginx ${VERSION} installed successfully"

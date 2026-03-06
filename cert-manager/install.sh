#!/bin/bash
set -euo pipefail

VERSION="${CERT_MANAGER_VERSION:-v1.17.1}"
MANIFEST_URL="https://github.com/cert-manager/cert-manager/releases/download/${VERSION}/cert-manager.yaml"

echo "Installing cert-manager ${VERSION}..."
kubectl apply -f "${MANIFEST_URL}"

echo "Waiting for cert-manager to be ready..."
kubectl -n cert-manager rollout status deployment/cert-manager --timeout=120s
kubectl -n cert-manager rollout status deployment/cert-manager-webhook --timeout=120s
kubectl -n cert-manager rollout status deployment/cert-manager-cainjector --timeout=120s

echo "cert-manager ${VERSION} installed successfully"

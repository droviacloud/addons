#!/bin/bash
set -euo pipefail

VERSION="${METRICS_SERVER_VERSION:-v0.7.2}"
MANIFEST_URL="https://github.com/kubernetes-sigs/metrics-server/releases/download/${VERSION}/components.yaml"

echo "Installing metrics-server ${VERSION}..."
kubectl apply -f "${MANIFEST_URL}"

# Patch for clusters with self-signed kubelet certificates
echo "Patching metrics-server for kubelet-insecure-tls..."
kubectl -n kube-system patch deployment metrics-server \
  --type='json' \
  -p='[{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--kubelet-insecure-tls"}]' 2>/dev/null || true

echo "Waiting for metrics-server to be ready..."
kubectl -n kube-system rollout status deployment/metrics-server --timeout=120s

echo "metrics-server ${VERSION} installed successfully"

#!/bin/bash
set -euo pipefail

VERSION="${RANCHER_VERSION:-2.13.3}"
HOSTNAME="${RANCHER_HOSTNAME:?RANCHER_HOSTNAME is required (e.g., rancher.example.com)}"

echo "Installing Rancher ${VERSION}..."

# cert-manager is required
if ! kubectl get ns cert-manager &>/dev/null; then
  echo "ERROR: cert-manager is required. Install it first."
  exit 1
fi

helm repo add rancher-stable https://releases.rancher.com/server-charts/stable 2>/dev/null || true
helm repo update rancher-stable

helm upgrade --install rancher rancher-stable/rancher \
  --namespace cattle-system --create-namespace \
  --version "${VERSION}" \
  --set hostname="${HOSTNAME}" \
  --set ingress.tls.source=letsEncrypt \
  --set letsEncrypt.ingress.class=nginx \
  --wait --timeout 600s

echo "Rancher ${VERSION} installed successfully"
echo ""
echo "Access at: https://${HOSTNAME}"
echo "Get bootstrap password:"
echo "  kubectl -n cattle-system get secret bootstrap-secret -o jsonpath='{.data.bootstrapPassword}' | base64 -d"

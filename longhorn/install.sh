#!/bin/bash
set -euo pipefail

VERSION="${LONGHORN_VERSION:-1.11.0}"

echo "Installing Longhorn ${VERSION}..."

# Prerequisites check
echo "Checking prerequisites..."
for cmd in open-iscsi nfs-common; do
  if ! dpkg -l | grep -q "${cmd}" 2>/dev/null; then
    echo "WARNING: ${cmd} may not be installed on nodes. Longhorn requires it."
  fi
done

helm repo add longhorn https://charts.longhorn.io 2>/dev/null || true
helm repo update longhorn

helm upgrade --install longhorn longhorn/longhorn \
  --namespace longhorn-system --create-namespace \
  --version "${VERSION}" \
  --set defaultSettings.defaultDataPath=/var/lib/longhorn \
  --wait --timeout 600s

echo "Longhorn ${VERSION} installed successfully"
echo ""
echo "Access the UI via:"
echo "  kubectl -n longhorn-system port-forward svc/longhorn-frontend 8080:80"

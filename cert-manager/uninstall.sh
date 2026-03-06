#!/bin/bash
set -euo pipefail

VERSION="${CERT_MANAGER_VERSION:-v1.17.1}"
MANIFEST_URL="https://github.com/cert-manager/cert-manager/releases/download/${VERSION}/cert-manager.yaml"

echo "Uninstalling cert-manager..."
kubectl delete -f "${MANIFEST_URL}" --ignore-not-found

echo "cert-manager removed"

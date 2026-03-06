#!/bin/bash
set -euo pipefail

VERSION="${ARGOCD_VERSION:-v2.14.3}"
NAMESPACE="${ARGOCD_NAMESPACE:-argocd}"
MANIFEST_URL="https://raw.githubusercontent.com/argoproj/argo-cd/${VERSION}/manifests/install.yaml"

echo "Uninstalling Argo CD..."
kubectl delete -n "${NAMESPACE}" -f "${MANIFEST_URL}" --ignore-not-found
kubectl delete namespace "${NAMESPACE}" --ignore-not-found

echo "Argo CD removed"

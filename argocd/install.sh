#!/bin/bash
set -euo pipefail

VERSION="${ARGOCD_VERSION:-v2.14.3}"
NAMESPACE="${ARGOCD_NAMESPACE:-argocd}"
MANIFEST_URL="https://raw.githubusercontent.com/argoproj/argo-cd/${VERSION}/manifests/install.yaml"

echo "Installing Argo CD ${VERSION}..."
kubectl create namespace "${NAMESPACE}" --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -n "${NAMESPACE}" -f "${MANIFEST_URL}"

echo "Waiting for Argo CD to be ready..."
kubectl -n "${NAMESPACE}" rollout status deployment/argocd-server --timeout=180s

echo "Argo CD ${VERSION} installed successfully"
echo ""
echo "Default admin password:"
echo "  kubectl -n ${NAMESPACE} get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d"

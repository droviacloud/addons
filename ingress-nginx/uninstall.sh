#!/bin/bash
set -euo pipefail

VERSION="${INGRESS_NGINX_VERSION:-v1.12.1}"
MANIFEST_URL="https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-${VERSION}/deploy/static/provider/cloud/deploy.yaml"

echo "Uninstalling ingress-nginx..."
kubectl delete -f "${MANIFEST_URL}" --ignore-not-found

echo "ingress-nginx removed"

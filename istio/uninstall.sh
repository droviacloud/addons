#!/bin/bash
set -euo pipefail

VERSION="${ISTIO_VERSION:-1.25.4}"

echo "Uninstalling Istio..."

helm uninstall istio-ingress --namespace istio-ingress 2>/dev/null || true
helm uninstall istiod --namespace istio-system 2>/dev/null || true
helm uninstall istio-base --namespace istio-system 2>/dev/null || true

kubectl delete namespace istio-ingress --ignore-not-found
kubectl delete namespace istio-system --ignore-not-found

echo "Istio removed"

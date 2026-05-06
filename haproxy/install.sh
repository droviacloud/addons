#!/bin/bash
set -euo pipefail

VERSION="${HAPROXY_VERSION:-1.41.4}"

echo "Installing HAProxy Kubernetes Ingress Controller ${VERSION}..."

helm repo add haproxytech https://haproxytech.github.io/helm-charts 2>/dev/null || true
helm repo update haproxytech

helm upgrade --install haproxy-kubernetes-ingress haproxytech/kubernetes-ingress \
  --namespace haproxy-controller --create-namespace \
  --version "${VERSION}" \
  --set controller.service.type=LoadBalancer \
  --set controller.ingressClass=haproxy \
  --set controller.ingressClassResource.name=haproxy \
  --set controller.ingressClassResource.default=false \
  --wait --timeout 300s

echo "HAProxy ${VERSION} installed successfully"
echo ""
echo "IngressClass: haproxy (use 'ingressClassName: haproxy' in your Ingress resources)"
echo "Service: haproxy-kubernetes-ingress in namespace haproxy-controller (LoadBalancer)"

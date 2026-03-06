#!/bin/bash
set -euo pipefail

echo "Uninstalling Rancher..."

helm uninstall rancher --namespace cattle-system 2>/dev/null || true
kubectl delete namespace cattle-system --ignore-not-found --timeout=300s

echo "Rancher removed"
echo "NOTE: Rancher CRDs may need manual cleanup. See:"
echo "  https://ranchermanager.docs.rancher.com/getting-started/installation-and-upgrade/other-installation-methods/rancher-on-a-single-node-with-docker/uninstall-rancher"

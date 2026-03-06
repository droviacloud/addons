#!/bin/bash
set -euo pipefail

echo "Uninstalling Kyverno..."

helm uninstall kyverno --namespace kyverno 2>/dev/null || true
kubectl delete namespace kyverno --ignore-not-found

echo "Kyverno removed"

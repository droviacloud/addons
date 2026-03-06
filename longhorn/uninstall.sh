#!/bin/bash
set -euo pipefail

echo "Uninstalling Longhorn..."

# Longhorn requires deleting the uninstall job first
kubectl -n longhorn-system patch -p '{"value": "true"}' --type=merge lhs deleting-confirmation-flag 2>/dev/null || true

helm uninstall longhorn --namespace longhorn-system 2>/dev/null || true
kubectl delete namespace longhorn-system --ignore-not-found --timeout=300s

echo "Longhorn removed"

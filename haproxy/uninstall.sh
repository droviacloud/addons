#!/bin/bash
set -euo pipefail

echo "Uninstalling HAProxy Ingress..."

helm uninstall haproxy-kubernetes-ingress -n haproxy-controller --ignore-not-found
kubectl delete namespace haproxy-controller --ignore-not-found

echo "HAProxy removed"

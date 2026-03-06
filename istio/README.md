# Istio

Service mesh that provides traffic management, security, and observability for microservices.

## Version

1.25.4

## What it does

- Mutual TLS (mTLS) between services automatically
- Traffic routing, canary deployments, circuit breaking
- Distributed tracing and metrics collection
- Ingress/egress gateway management

## Prerequisites

- Kubernetes 1.27+
- Helm 3.x

## Components installed

| Component | Namespace | Description |
|-----------|-----------|-------------|
| `istio-base` | `istio-system` | CRDs and cluster-wide resources |
| `istiod` | `istio-system` | Control plane (Pilot, Citadel, Galley) |
| `istio-ingress` | `istio-ingress` | Ingress gateway (optional) |

## Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `ISTIO_VERSION` | `1.25.4` | Version to install |
| `ISTIO_INGRESS_ENABLED` | `true` | Install ingress gateway |

## Post-install

Enable sidecar injection for a namespace:

```bash
kubectl label namespace default istio-injection=enabled
```

## Resources

- [Official docs](https://istio.io/latest/docs/)
- [GitHub](https://github.com/istio/istio)

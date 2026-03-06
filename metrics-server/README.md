# Metrics Server

Cluster-wide aggregator of resource usage data for Kubernetes.

## Version

v0.7.2

## What it does

- Collects CPU and memory metrics from kubelets
- Enables `kubectl top nodes` and `kubectl top pods`
- Required for Horizontal Pod Autoscaler (HPA)

## Prerequisites

- Kubernetes 1.25+

## Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `METRICS_SERVER_VERSION` | `v0.7.2` | Version to install |

## Notes

- `--kubelet-insecure-tls` is enabled for DKE clusters with self-signed certificates
- Installed in `kube-system` namespace

## Resources

- [GitHub](https://github.com/kubernetes-sigs/metrics-server)

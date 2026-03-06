# Rancher

Multi-cluster Kubernetes management platform.

## Version

2.13.3

## What it does

- Web UI for managing multiple Kubernetes clusters
- User management with RBAC, LDAP/AD integration
- Application catalog and deployment
- Cluster provisioning and lifecycle management
- Monitoring and alerting built-in

## Prerequisites

- Kubernetes 1.25+
- Helm 3.x
- **cert-manager** (must be installed first)
- **ingress-nginx** (recommended for ingress)
- A DNS record pointing to the cluster

## Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `RANCHER_VERSION` | `2.13.3` | Version to install |
| `RANCHER_HOSTNAME` | *required* | FQDN for Rancher (e.g., `rancher.example.com`) |

## Post-install

Get the bootstrap password:

```bash
kubectl -n cattle-system get secret bootstrap-secret -o jsonpath='{.data.bootstrapPassword}' | base64 -d
```

Access the UI at `https://<RANCHER_HOSTNAME>` and set your admin password.

## Resources

- [Official docs](https://ranchermanager.docs.rancher.com/)
- [GitHub](https://github.com/rancher/rancher)

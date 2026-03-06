# Argo CD

Declarative GitOps continuous delivery tool for Kubernetes.

## Version

v2.14.3

## What it does

- Syncs Kubernetes manifests from Git repositories
- Web UI for managing applications and deployments
- Automated and manual sync with drift detection
- Multi-cluster support

## Prerequisites

- Kubernetes 1.25+
- Ingress controller (for web UI access)

## Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `ARGOCD_VERSION` | `v2.14.3` | Version to install |
| `ARGOCD_NAMESPACE` | `argocd` | Namespace for Argo CD |

## Post-install

Get the initial admin password:

```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d
```

Access the web UI via the endpoint provided after installation.

## Resources

- [Official docs](https://argo-cd.readthedocs.io/)
- [GitHub](https://github.com/argoproj/argo-cd)

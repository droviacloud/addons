# Cert Manager

Automatic TLS certificate management for Kubernetes using Let's Encrypt.

## Version

v1.17.1

## What it does

- Automates issuance and renewal of TLS certificates
- Supports Let's Encrypt, HashiCorp Vault, Venafi, and self-signed CAs
- Creates `Certificate`, `Issuer`, and `ClusterIssuer` CRDs

## Prerequisites

- Kubernetes 1.25+

## Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `CERT_MANAGER_VERSION` | `v1.17.1` | Version to install |

## Post-install

After installing, create a `ClusterIssuer` for Let's Encrypt:

```yaml
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    email: your-email@example.com
    privateKeySecretRef:
      name: letsencrypt-prod
    solvers:
      - http01:
          ingress:
            class: nginx
```

## Resources

- [Official docs](https://cert-manager.io/docs/)
- [GitHub](https://github.com/cert-manager/cert-manager)

# Ingress NGINX

Production-grade ingress controller for Kubernetes, maintained by the Kubernetes community.

## Version

v1.12.1

## What it does

- Routes external HTTP/HTTPS traffic to cluster services
- TLS termination, path-based routing, host-based routing
- Rate limiting, IP whitelisting, basic auth

## Prerequisites

- Kubernetes 1.25+

## Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `INGRESS_NGINX_VERSION` | `v1.12.1` | Version to install |

## Post-install

Create an `Ingress` resource to route traffic:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-app
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt-prod
spec:
  ingressClassName: nginx
  tls:
    - hosts:
        - app.example.com
      secretName: app-tls
  rules:
    - host: app.example.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: my-app
                port:
                  number: 80
```

## Notes

- `externalTrafficPolicy` is patched to `Cluster` for DKE compatibility
- Works with cert-manager for automatic TLS

## Resources

- [Official docs](https://kubernetes.github.io/ingress-nginx/)
- [GitHub](https://github.com/kubernetes/ingress-nginx)

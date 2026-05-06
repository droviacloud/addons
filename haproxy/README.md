# HAProxy Kubernetes Ingress Controller

High-performance HTTP/TCP load balancer and ingress controller, maintained by HAProxy Technologies.

## Version

1.41.4 (helm chart) — installs HAProxy 3.0.x

## What it does

- L7 ingress (HTTP/HTTPS) with path/host routing, TLS termination
- L4 TCP ingress for non-HTTP services
- Native Prometheus metrics, runtime API, dynamic config reload
- Alternative to NGINX Ingress with lower latency at high RPS

## Prerequisites

- Kubernetes 1.25+
- Helm 3.x available on the cluster
- A LoadBalancer-capable provider (drovia-ccm em DKE)

## Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `HAPROXY_VERSION` | `1.41.4` | Helm chart version (`haproxytech/kubernetes-ingress`) |

To override the chart version:

```bash
HAPROXY_VERSION=1.42.0 ./install.sh
```

## IngressClass

This addon registers `haproxy` as a non-default IngressClass. Coexists with `nginx` (ingress-nginx) — choose per Ingress via `ingressClassName`.

## Post-install

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-app
spec:
  ingressClassName: haproxy
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

LoadBalancer IP is allocated by drovia-ccm via the public IP pool.

## Notes

- Default ingress class is NOT set (`ingressClassResource.default=false`) to avoid conflicts when both `nginx` and `haproxy` are installed
- HAProxy controller listens on 80/443 (HTTP/HTTPS) and 1024 (stats)
- For TCP ingress, see [official docs](https://www.haproxy.com/documentation/kubernetes-ingress/community/configuration-reference/tcp-services/)

## Resources

- [Helm chart](https://github.com/haproxytech/helm-charts/tree/main/kubernetes-ingress)
- [Official docs](https://www.haproxy.com/documentation/kubernetes-ingress/community/)
- [GitHub](https://github.com/haproxytech/kubernetes-ingress)

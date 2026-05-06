# HAProxy Kubernetes Ingress

High-performance HTTP/TCP load balancer and ingress controller, maintained by HAProxy Technologies.

Manifest gerado a partir do helm chart oficial `haproxytech/kubernetes-ingress` (Apache 2.0), com versões pinadas pra stack Drovia DKE.

## Version

- Helm chart: `haproxytech/kubernetes-ingress` 1.49.0
- HAProxy Ingress Controller image: `haproxytech/kubernetes-ingress:3.2.6`

## What it does

- L7 ingress (HTTP/HTTPS) com path/host routing, TLS termination
- L4 TCP ingress para serviços não-HTTP
- Service `haproxy-ingress` tipo `LoadBalancer` (drovia-ccm aloca IP do pool público)
- IngressClass `haproxy` registrada não-default — coexiste com `nginx`

## Resources criados

- Namespace `haproxy-controller`
- ServiceAccount + ClusterRole + ClusterRoleBinding
- ConfigMap (config inicial do HAProxy)
- Deployment + Service (LoadBalancer)
- IngressClass (`haproxy`)
- Job de bootstrap (criação de assets)

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

## Prerequisites

- Kubernetes 1.25+
- LoadBalancer-capable provider (drovia-ccm em DKE)

## Como atualizar este addon

```bash
helm repo add haproxytech https://haproxytech.github.io/helm-charts
helm repo update haproxytech

helm template haproxy-ingress haproxytech/kubernetes-ingress \
  --version <NOVA_VERSAO> \
  --namespace haproxy-controller \
  --set controller.service.type=LoadBalancer \
  --set controller.ingressClass=haproxy \
  --set controller.ingressClassResource.name=haproxy \
  --set controller.ingressClassResource.default=false \
  > /tmp/haproxy.yaml

# Prepend Namespace (helm template não emite com --create-namespace)
# e commitar como app.yaml
```

## Resources

- [HAProxy Kubernetes Ingress docs](https://www.haproxy.com/documentation/kubernetes-ingress/community/)
- [GitHub](https://github.com/haproxytech/kubernetes-ingress)
- [Helm chart](https://github.com/haproxytech/helm-charts/tree/main/kubernetes-ingress)

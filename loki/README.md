# Grafana Loki

Horizontally-scalable, multi-tenant log aggregation system inspired by Prometheus.

## Version

v3.6.7 (chart 6.53.0)

## What it does

- Aggregates and indexes log streams from pods and nodes
- Integrates with Grafana for log visualization
- Lightweight — indexes labels, not full log content
- LogQL query language (similar to PromQL)

## Prerequisites

- Kubernetes 1.25+
- Helm 3.x

## Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `LOKI_VERSION` | `6.53.0` | Helm chart version |

## Default install mode

Installed as **SingleBinary** (all-in-one) with filesystem storage. Suitable for small to medium clusters. For production at scale, switch to `deploymentMode=SimpleScalable` with object storage (S3/R2).

## Post-install

Install a log collector (Promtail or Grafana Alloy) to ship logs:

```bash
helm install promtail grafana/promtail \
  --namespace loki \
  --set config.clients[0].url=http://loki.loki.svc.cluster.local:3100/loki/api/v1/push
```

## Resources

- [Official docs](https://grafana.com/docs/loki/latest/)
- [GitHub](https://github.com/grafana/loki)
- [LogQL reference](https://grafana.com/docs/loki/latest/logql/)

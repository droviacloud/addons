# Longhorn

Cloud-native distributed block storage for Kubernetes.

## Version

1.11.0

## What it does

- Provides persistent block storage volumes for stateful workloads
- Automatic replication across nodes for high availability
- Built-in backup and restore (S3-compatible targets)
- Snapshot and disaster recovery
- Web UI for volume management

## Prerequisites

- Kubernetes 1.25+
- Helm 3.x
- `open-iscsi` installed on all nodes
- `nfs-common` installed on all nodes (for backup)

## Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `LONGHORN_VERSION` | `1.11.0` | Version to install |

## Post-install

Set Longhorn as the default StorageClass:

```bash
kubectl patch storageclass longhorn -p '{"metadata":{"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
```

Create a PVC:

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-data
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: longhorn
  resources:
    requests:
      storage: 10Gi
```

## Resources

- [Official docs](https://longhorn.io/docs/)
- [GitHub](https://github.com/longhorn/longhorn)

# Kyverno

Kubernetes-native policy engine for validating, mutating, and generating resources.

## Version

v1.17.1 (chart 3.7.1)

## What it does

- Enforce security policies (e.g., block privileged containers)
- Mutate resources (e.g., add default labels, inject sidecars)
- Generate resources (e.g., create NetworkPolicies automatically)
- Validate images and signatures

## Prerequisites

- Kubernetes 1.25+
- Helm 3.x

## Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `KYVERNO_VERSION` | `3.7.1` | Helm chart version |

## Post-install

Apply a policy to require labels on all pods:

```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: require-labels
spec:
  validationFailureAction: Enforce
  rules:
    - name: check-team-label
      match:
        any:
          - resources:
              kinds:
                - Pod
      validate:
        message: "Label 'team' is required"
        pattern:
          metadata:
            labels:
              team: "?*"
```

## Resources

- [Official docs](https://kyverno.io/docs/)
- [GitHub](https://github.com/kyverno/kyverno)
- [Policy library](https://kyverno.io/policies/)

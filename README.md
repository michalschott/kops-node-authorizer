This is updated Dockerfile for node-authorizer used by [KOPS](https://github.com/kubernetes/kops).

To run it, update your cluster spec file with:
```
spec:
  nodeAuthorization:
    nodeAuthorizer:
      image: streetmanagerops/kops-node-authorizer:v1.18.3
```

[Docker Hub](https://hub.docker.com/r/streetmanagerops/kops-node-authorizer)

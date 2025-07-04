# k3s-1password

The EKS expects 2 secrets to be created in the cluster manually:
<https://dev.to/3deep5me/using-1password-with-external-secrets-operator-in-a-gitops-way-4lo4>
create connect token and 1password credentials manually for now

```bash
kubectl create secret generic op-credentials -n external-secrets --from-literal=1password-credentials.json="$(cat /path/to/1password-credentials.json | base64)"
```

```bash
export OP_CONNECT_TOKEN="your_connect_token"
kubectl create secret -n external-secrets generic onepassword-connect-token --from-literal=token=$OP_CONNECT_TOKEN
```

# k3s-1password

## Installation

The operator expects a token to be present for each vault. This can be bootstrapped by creating a secret in the `external-secrets` namespace with the name `onepassword-connect-token`. The token can be generated from on the 1password dev page.

```bash
export OP_CONNECT_TOKEN="your_connect_token"
kubectl create secret -n external-secrets generic onepassword-connect-token --from-literal=token=$OP_CONNECT_TOKEN
```

## Configurations

By default the external-secrets operator in this chart has all crd permissions enabled. THIS IS NOT SAFE FOR PRODUCTION USE. Prefference is to deploy a custom operator in each namespace or configure the operator in this chart to only reconsile certain namespaces and only llow nessecary crds.

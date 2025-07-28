{{- if .Values.scopedVaults.enabled }}
{{- range .Values.scopedVaults.vaults }}
---
apiVersion: external-secrets.io/v1
kind: SecretStore
metadata:
  name: {{ .name }}
  namespace: {{ .namespace }}
spec:
  provider:
    onepassword:
      connectHost: http://onepassword-connect:8080
      vaults:
        {{- range .vaults }}
        {{ .name }}: {{ .priority }}
        {{- end }} 
      auth:
        secretRef:
          connectTokenSecretRef:
            name: {{ $.Values.connectTokenSecretName }}
            key: token
            namespace: {{ $.Values.namespace }}
{{- end }}
{{- end }}

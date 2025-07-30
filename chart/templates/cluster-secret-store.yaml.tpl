{{- if .Values.clusterVaults.enabled }}
{{- range .Values.clusterVaults.vaults }}
{{- if .enabled }}
---
apiVersion: external-secrets.io/v1
kind: ClusterSecretStore
metadata:
  name: {{ .name }}
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
{{- end }}

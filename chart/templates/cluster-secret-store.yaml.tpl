{{- if .Values.enableClusterVaults }}
{{- range .Values.clusterVaults }}
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
        {{- range .remoteVaults }}
        {{ .name }}: {{ .priority }}
        {{- end }} 
      auth:
        secretRef:
          connectTokenSecretRef:
            name: {{ $.Values.connectTokenSecretName }}
            key: token
            namespace: {{ $.Values.namespace }}
{{- end }}
{{- else }}

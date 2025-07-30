{{- if .Values.clusterVaults.enabled }}
{{- range .Values.clusterVaults.vaults }}
{{- if .enabled }}
---
apiVersion: external-secrets.io/v1
kind: ClusterSecretStore
metadata:
  name: {{ .name | quote }}
spec:
  provider:
    onepassword:
      connectHost: http://onepassword-connect:8080
      vaults:
        {{- range .vaults }}
        {{ .name | quote }}: {{ .priority | quote }}
        {{- end }}
      auth:
        secretRef:
          connectTokenSecretRef:
            name: {{ $.Values.connectTokenSecretName | quote }}
            key: token
            namespace: {{ $.Values.namespace | quote }}
{{- end }}
{{- end }}
{{- end }}

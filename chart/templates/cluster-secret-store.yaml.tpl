{{- if .Values.enabled }}{{- if .Values.clusterStores.enabled }}
{{- range .Values.clusterStores.stores }}
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
        {{ .name | quote }}: {{ .priority }}
        {{- end }}
      auth:
        secretRef:
          connectTokenSecretRef:
            name: {{ $.Values.connectTokenSecretName | quote }}
            key: token
            namespace: {{ $.Values.namespace.name | quote }}
{{- end }}
{{- end }}
{{- end }}{{- end }}

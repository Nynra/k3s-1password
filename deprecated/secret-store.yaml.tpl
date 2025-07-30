{{- .Values.enabled }}{{- if .Values.scopedStores.enabled }}
{{- range .Values.scopedStores.stores }}
{{- if .enabled }}
---
apiVersion: external-secrets.io/v1
kind: SecretStore
metadata:
  name: {{ .name | quote }}
  namespace: {{ .namespace.name | quote }}
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
            namespace: {{ $.Values.namespace | quote }}
{{- end }}
{{- end }}
{{- end }}

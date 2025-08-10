{{- if .Values.enabled }}{{- if .Values.clusterStores.enabled }}
{{- range .Values.clusterStores.stores }}
{{- if .enabled | default true }}
---
apiVersion: external-secrets.io/v1
kind: ClusterSecretStore
metadata:
  name: {{ .name | quote }}
  namespace: default
spec:
  provider:
    onepasswordSDK:
      vault: {{ .vault | quote }}
      auth:
        serviceAccountSecretRef:
          name: {{ .accessToken | quote }}
          {{- if .accessTokenField }}
          key: {{ .accessTokenField | quote }}
          {{- else }}
          key: token
          {{- end }}
{{- end }}
{{- end }}
{{- end }}{{- end }}

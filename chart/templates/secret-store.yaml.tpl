{{- if .Values.enabled }}{{- if .Values.scopedStores.enabled }}
{{- range .Values.scopedStores.stores }}
{{- if .enabled | default true }}
---
apiVersion: external-secrets.io/v1
kind: SecretStore
metadata:
  name: {{ .name | quote }}
spec:
  provider:
    onepasswordSDK:
      vault: {{ .vault | quote }}
      auth:
        secretRef:
          serviceAccountTokenSecretRef:
            name: {{ .accessToken | quote }}
            {{- if .accessTokenField }}
            key: {{ .accessTokenField | quote }}
            {{- else }}
            key: token
            {{- end }}
{{- end }}
{{- end }}
{{- end }}{{- end }}

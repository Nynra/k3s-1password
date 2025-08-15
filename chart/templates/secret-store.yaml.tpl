{{- if .Values.enabled }}{{- if .Values.scopedStores.enabled }}
{{- range .Values.scopedStores.stores }}
{{- if .enabled }}
---
apiVersion: external-secrets.io/v1
kind: SecretStore
metadata:
  name: {{ .name | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "2"
    {{- if $.Values.global.commonAnnotations }}
    # Global annotations
    {{- toYaml $.Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
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

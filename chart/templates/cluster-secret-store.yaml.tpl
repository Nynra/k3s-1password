{{- if .Values.enabled }}{{- if .Values.clusterStores.enabled }}
{{- range .Values.clusterStores.stores }}
{{- if .enabled }}
---
apiVersion: external-secrets.io/v1
kind: ClusterSecretStore
metadata:
  name: {{ .name | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "2"
    {{- if $.Values.global.commonAnnotations }}
    # Global annotations
    {{- toYaml $.Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
  {{- if $.Values.global.commonLabels }}   
  labels:
    # Global labels
    {{- toYaml $.Values.external-secrets.commonLabels | nindent 4 }}
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
          namespace: {{ $.Release.Namespace | quote }}
{{- end }}
{{- end }}
{{- end }}{{- end }}

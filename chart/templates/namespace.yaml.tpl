apiVersion: v1
kind: Namespace
metadata:
  name: {{ .Release.Namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "-5"
    {{- if $.Values.global.commonAnnotations }}
    # Global annotations
    {{- toYaml $.Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
  {{- if $.Values.global.commonLabels }}  
  labels:
    # Global labels
    {{- toYaml $.Values.external-secrets.commonLabels | nindent 4 }}
  {{- end }}
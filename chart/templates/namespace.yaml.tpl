apiVersion: v1
kind: Namespace
metadata:
  name: {{ .Release.Namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "-5"
    # Global annotations
    {{- if .Values.global.commonAnnotations }}
    {{- toYaml .Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
  labels:
    # Global labels
    {{- if .Values.global.commonLabels }}
    {{- toYaml .Values.global.commonLabels | nindent 4 }}
    {{- end }}
    
{{- if .Values.namespace.enabled }}
apiVersion: v1
kind: Namespace
metadata:
  name: {{ .Values.namespace.name | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "-5"
    # Global annotations
    {{- if .Values.namespace.commonAnnotations }}
    {{- toYaml .Values.namespace.commonAnnotations | nindent 4 }}
    {{- end }}
    # Custom annotations
    {{- if .Values.namespace.commonAnnotations }}
    {{- toYaml .Values.namespace.commonAnnotations | nindent 4 }}
    {{- end }}
  labels:
    # Global labels
    {{- if .Values.namespace.commonLabels }}
    {{- toYaml .Values.namespace.commonLabels | nindent 4 }}
    {{- end }}
    # Custom labels
    {{- if .Values.namespace.commonLabels }}
    {{- toYaml .Values.namespace.commonLabels | nindent 4 }}
    {{- end }}
{{- end }}{{- end }}
    
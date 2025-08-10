{{- if .Values.enabled }}{{- if .Values.externalSecrets.enabled }}{{- if .Values.externalSecrets.enabled }}
{{- range .Values.externalSecrets.secrets }}
{{- if .enabled }}
{{- $remoteSecretName := .remoteName | quote }}
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: {{ .name }}
  namespace: {{ $.Release.Namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "1"
    # Global annotations
    {{- if $.Values.global.commonAnnotations }}
    {{- toYaml $.Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
spec:
  secretStoreRef:
    kind: "SecretStore"
    name: {{ .storeName | quote }}
  target:
    creationPolicy: Owner
  data:
    {{- range .fieldMappings}}
    - secretKey: {{ .secretKey | quote }}
      remoteRef:
        key: {{ $remoteSecretName | quote }}
        property: {{ .remoteField | quote }}
        conversionStrategy: Default	
        decodingStrategy: None
        metadataPolicy: None
    {{- end }}
{{- end }}
{{- end }}
{{- end }}{{- end }}{{- end }}
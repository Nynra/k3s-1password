{{- if .Values.enabled }}{{- if .Values.externalSecrets.enabled }}
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
    template:
      engineVersion: v2
      metadata:
        {{- if .labels | default $.Values.external-secrets.commonLabels }}
        labels:
          # Global labels
          {{- if $.Values.external-secrets.commonLabels }}
          {{- toYaml $.Values.external-secrets.commonLabels | nindent 4 }}
          {{- end }}
          {{- if .labels }}
          {{- toYaml .labels | nindent 4 }}
          {{- end }}
        {{- end }}
        {{- if $.Values.external-secrets.commonAnnotations | $.Values.externalSecrets.allowReflection }}
        annotations:
          reflector.v1.k8s.emberstack.com/reflection-allowed: {{ .reflection.enabled | quote }}
          reflector.v1.k8s.emberstack.com/reflection-allowed-namespaces: {{ .reflection.allowedNamespaces | quote }}
          reflector.v1.k8s.emberstack.com/reflection-auto-enabled: {{ .reflection.allowAutoReflection | quote }}
          reflector.v1.k8s.emberstack.com/reflection-auto-namespaces: {{ .reflection.autoReflectionNamespaces | quote }}
          {{- if $.Values.global.commonAnnotations }}
          {{- toYaml $.Values.global.commonAnnotations | nindent 4 }}
          {{- end }}
        {{- end }}
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
{{- end }}{{- end }}
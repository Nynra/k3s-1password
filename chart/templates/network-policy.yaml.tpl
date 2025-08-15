{{- if .Values.enabled }}{{- if .Values.networkPolicy.enabled }}
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: "{{ .Release.Name }}-network-policy"
  namespace: {{ .Release.Namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "0"
    {{- if $.Values.global.commonAnnotations }}
      # Global annotations 
      {{- toYaml $.Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
spec:
  podSelector: {}
  policyTypes:
    - Ingress
    - Egress
  ingress:
    {{ if .Values.networkPolicy.monitoring.enabled }}
    - from:
        - namespaceSelector:
            matchLabels:
              namespace: {{ .Values.networkPolicy.monitoring.namespace | quote }}
      ports:
        - port: 8080
    {{- end }}
    - from:
        - podSelector:
            matchLabels:
              app.kubernetes.io/name: external-secrets
    - from:
        - podSelector:
            matchLabels:
              app.kubernetes.io/name: external-secrets-cert-controller
    - from:
        - podSelector:
            matchLabels:
              app.kubernetes.io/name: external-secrets-webhook
  egress:
    - to:
        - namespaceSelector: {}
          podSelector:
            matchLabels:
              k8s-app: kube-dns
      ports:
        - port: 53
          protocol: UDP
    - to:
        - podSelector:
            matchLabels:
              app.kubernetes.io/name: external-secrets
    - to:
        - podSelector:
            matchLabels:
              app.kubernetes.io/name: external-secrets-cert-controller
    - to:
        - podSelector:
            matchLabels:
              app.kubernetes.io/name: external-secrets-webhook
{{- end }}{{- end }}
{{- if .Values.enabled }}{{- if .Values.networkPolicy.enabled }}
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: "{{ .Release.Name }}-network-policy"
  namespace: {{ .Release.Namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "1"
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
        - podSelector:
            matchLabels:
              k8s-app: kube-dns
      ports:
        - port: 53
          protocol: UDP
    {{ if .Values.networkPolicy.kubernetesApiIps }}
    - to:
        {{- range .Values.networkPolicy.kubernetesApiIps -}}
        - ipBlock:
            cidr: {{ . | quote }}
        {{- end }}
      ports:
        - port: {{ .Values.networkPolicy.kubernetesApiPort | default "443" | quote }}
          protocol: TCP
    {{- end }}
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
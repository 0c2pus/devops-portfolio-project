{{/* Basic helpers for names & labels */}}
{{- define "portfolio-app.name" -}}
{{- default .Chart.Name .Values.nameOverride -}}
{{- end -}}

{{- define "portfolio-app.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name (include "portfolio-app.name" .) | trunc 63 -}}
{{- end -}}
{{- end -}}

{{- define "portfolio-app.labels" -}}
app.kubernetes.io/name: {{ include "portfolio-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "hello-argo.name" -}}
{{- .Chart.Name -}}
{{- end -}}

{{- define "hello-argo.fullname" -}}
{{- if contains .Chart.Name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "hello-argo.labels" -}}
app.kubernetes.io/name: {{ include "hello-argo.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "hello-argo.selectorLabels" -}}
app.kubernetes.io/name: {{ include "hello-argo.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

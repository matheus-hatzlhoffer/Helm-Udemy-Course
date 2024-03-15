{{- define "scratch.labels" }}
    helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
    app.kubernetes.io/instance: {{ .Release.Name | quote}}
    app.kubernetes.io/version: {{ .Chart.AppVersion | quote}}
    app.kubernetes.io/managed-by: {{ .Release.Service | quote}}
{{- end }}

{{- define "scratch.version" -}}
app_name: {{ .Chart.Name }}
app_version: {{ .Chart.Version | quote }}
{{- end -}}


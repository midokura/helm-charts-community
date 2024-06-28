{{/*
Expand the name of the chart.
*/}}
{{- define "nginx-static.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "nginx-static.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "nginx-static.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Midokura labels
*/}}
{{- define "charts.midokura.labels" -}}
{{- if .Values.global }}

{{- if .Values.global.team }}
team: {{ .Values.global.team }}
{{- end }}

{{- if .Values.global.service }}
service: {{ .Values.global.service }}
{{- end }}

{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "nginx-static.labels" -}}
helm.sh/chart: {{ include "nginx-static.chart" . }}
{{ include "nginx-static.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{ include "charts.midokura.labels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "nginx-static.selectorLabels" -}}
app.kubernetes.io/name: {{ include "nginx-static.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

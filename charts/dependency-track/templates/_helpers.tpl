{{/*
Expand the name of the chart.
*/}}
{{- define "dependency-track.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "dependency-track.fullname" -}}
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
{{- define "dependency-track.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "dependency-track.base.labels" -}}
helm.sh/chart: {{ include "dependency-track.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "dependency-track.api.labels" -}}
{{ include "dependency-track.base.labels" . }}
{{ include "dependency-track.api.selectorLabels" . }}
{{- end }}

{{- define "dependency-track.frontend.labels" -}}
{{ include "dependency-track.base.labels" . }}
{{ include "dependency-track.frontend.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "dependency-track.base.selectorLabels" -}}
app.kubernetes.io/name: {{ include "dependency-track.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "dependency-track.api.selectorLabels" -}}
{{ include "dependency-track.base.selectorLabels" . }}
app.kubernetes.io/component: apiserver
{{- end }}

{{- define "dependency-track.frontend.selectorLabels" -}}
{{ include "dependency-track.base.selectorLabels" . }}
app.kubernetes.io/component: frontend
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "dependency-track.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "dependency-track.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "dependency-track.pvcName" -}}
{{ include "dependency-track.fullname" . }}-data
{{- end }}

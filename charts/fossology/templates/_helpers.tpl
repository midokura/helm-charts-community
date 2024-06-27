{{/*
Expand the name of the chart.
*/}}
{{- define "fossology.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "fossology.fullname" -}}
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
{{- define "fossology.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "fossology.base.labels" -}}
helm.sh/chart: {{ include "fossology.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Values.global -}}
{{- if .Values.global.team }}
team: {{ .Values.global.team | quote }}
{{- end }}
{{- end }}
{{- end }}

{{- define "fossology.scheduler.labels" -}}
{{ include "fossology.base.labels" . }}
{{ include "fossology.scheduler.selectorLabels" . }}
{{- end }}

{{- define "fossology.web.labels" -}}
{{ include "fossology.base.labels" . }}
{{ include "fossology.web.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "fossology.base.selectorLabels" -}}
app.kubernetes.io/name: {{ include "fossology.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "fossology.scheduler.selectorLabels" -}}
{{ include "fossology.base.selectorLabels" . }}
app.kubernetes.io/component: scheduler
{{- end }}

{{- define "fossology.web.selectorLabels" -}}
{{ include "fossology.base.selectorLabels" . }}
app.kubernetes.io/component: web
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "fossology.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "fossology.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "fossology.pvcName" -}}
{{ include "fossology.fullname" . }}-data-repository
{{- end }}

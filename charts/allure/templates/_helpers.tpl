{{/*
Expand the name of the chart.
*/}}
{{- define "allure.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "allure.fullname" -}}
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
{{- define "allure.chart" -}}
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
{{- define "allure.labels" -}}
helm.sh/chart: {{ include "allure.chart" . }}
{{ include "allure-api.selectorLabels" . }}
{{ include "allure-ui.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Values.api.image.tag | default .Chart.AppVersion }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{ include "charts.midokura.labels" . }}
{{- end }}

{{/*
API Common labels
*/}}
{{- define "allure-api.labels" -}}
helm.sh/chart: {{ include "allure.chart" . }}
{{ include "allure-api.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Values.api.image.tag | default .Chart.AppVersion }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
UI Common labels
*/}}
{{- define "allure-ui.labels" -}}
helm.sh/chart: {{ include "allure.chart" . }}
{{ include "allure-ui.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Values.ui.image.tag }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
API Selector labels
*/}}
{{- define "allure-api.selectorLabels" -}}
app.kubernetes.io/name: {{ include "allure.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: api
{{- end }}

{{/*
UI Selector labels
*/}}
{{- define "allure-ui.selectorLabels" -}}
app.kubernetes.io/name: {{ include "allure.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: ui
{{- end }}

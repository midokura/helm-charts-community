{{/*
Expand the name of the chart.
*/}}
{{- define "salt.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "salt.fullname" -}}
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
{{- define "salt.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "salt.base.labels" -}}
helm.sh/chart: {{ include "salt.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Values.global.team }}
team: {{ .Values.global.team | quote }}
{{- end }}
{{- end }}

{{- define "salt.labels" -}}
{{ include "salt.base.labels" . }}
{{ include "salt.selectorLabels" . }}
{{- end }}

{{/*
  NOTE: Not including changing fields such as
  "version" and "chart" in "app" due to bug StatefulSet
  cannot be updated if using PVC and changing labels.
  helm/charts issue #7803
*/}}
{{- define "salt.master.labels" -}}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{ include "salt.master.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "salt.selectorLabels" -}}
app.kubernetes.io/name: {{ include "salt.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- define "salt.master.selectorLabels" -}}
{{ include "salt.selectorLabels" . }}
app.kubernetes.io/component: master
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "salt.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "salt.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

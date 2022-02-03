{{/*
Expand the name of the chart.
*/}}
{{- define "librenms.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "librenms.fullname" -}}
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
{{- define "librenms.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "librenms.base.labels" -}}
helm.sh/chart: {{ include "librenms.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "librenms.labels" -}}
{{ include "librenms.base.labels" . }}
{{ include "librenms.selectorLabels" . }}
{{- end }}

{{/*
  NOTE: Not including changing fields such as
  "version" and "chart" in "app" due to bug StatefulSet
  cannot be updated if using PVC and changing labels.
  helm/charts issue #7803
*/}}
{{- define "librenms.app.labels" -}}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{ include "librenms.app.selectorLabels" . }}
{{- end }}

{{- define "librenms.poller.labels" -}}
{{ include "librenms.base.labels" . }}
{{ include "librenms.poller.selectorLabels" . }}
{{- end }}

{{- define "librenms.syslog.labels" -}}
{{ include "librenms.base.labels" . }}
{{ include "librenms.syslog.selectorLabels" . }}
{{- end }}

{{- define "librenms.rrdcached.labels" -}}
{{ include "librenms.base.labels" . }}
{{ include "librenms.rrdcached.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "librenms.selectorLabels" -}}
app.kubernetes.io/name: {{ include "librenms.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- define "librenms.app.selectorLabels" -}}
{{ include "librenms.selectorLabels" . }}
app.kubernetes.io/component: app
{{- end }}
{{- define "librenms.poller.selectorLabels" -}}
{{ include "librenms.selectorLabels" . }}
app.kubernetes.io/component: poller
{{- end }}
{{- define "librenms.syslog.selectorLabels" -}}
{{ include "librenms.selectorLabels" . }}
app.kubernetes.io/component: syslog
{{- end }}
{{- define "librenms.rrdcached.selectorLabels" -}}
{{ include "librenms.selectorLabels" . }}
app.kubernetes.io/component: rrdcached
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "librenms.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "librenms.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{/*
Define the common environment variables for LibreNMS app
*/}}
{{- define "librenms.environment_ref_default" -}}
- secretRef:
    name: {{ include "librenms.fullname" . }}-env
- configMapRef:
    name: {{ include "librenms.fullname" . }}-env
{{- end }}

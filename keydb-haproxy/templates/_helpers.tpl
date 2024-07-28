{{- define "keydb.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name -}}
{{- end -}}

{{- define "keydb.name" -}}
{{- .Release.Name -}}
{{- end -}}

{{- define "haproxy.fullname" -}}
{{- printf "%s-%s" .Release.Name "haproxy" -}}
{{- end -}}

{{- define "haproxy.name" -}}
{{- printf "%s-haproxy" .Release.Name -}}
{{- end -}}

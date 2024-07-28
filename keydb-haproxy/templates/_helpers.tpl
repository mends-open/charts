{{- define "keydb.name" -}}
{{- "keydb" -}}
{{- end -}}

{{- define "keydb.fullname" -}}
{{- printf "%s-%s" .Release.Name "keydb" -}}
{{- end -}}

{{- define "haproxy.name" -}}
{{- "haproxy" -}}
{{- end -}}

{{- define "haproxy.fullname" -}}
{{- printf "%s-%s" .Release.Name "haproxy" -}}
{{- end -}}

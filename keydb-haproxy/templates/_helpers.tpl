# templates/_helpers.tpl
{{- define "keydb.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name -}}
{{- end -}}

{{- define "keydb.name" -}}
{{- printf "%s-%s" .Release.Name "keydb" -}}
{{- end -}}

#!/bin/bash

cat app_base/observability/loki/loki-helm-values.txt | kubectl create secret generic loki-helm-values --namespace observability --from-file=config=/dev/stdin --dry-run=client -o yaml > app_base/observability/loki/loki-helm-secret.yaml 

kubeseal --controller-namespace=default -n default < app_base/observability/loki/loki-helm-secret.yaml > app_base/observability/loki/loki-helm-values.yaml 

rm app_base/observability/loki/loki-helm-secret.yaml
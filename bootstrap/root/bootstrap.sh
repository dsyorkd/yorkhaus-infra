#!/bin/sh

helm template \
    --include-crds \
    --namespace argocd \
    argocd . \
    | kubectl apply -n argocd -f -

kubectl --namespace argocd wait --timeout=300s --for condition=ResourcesUpToDate \
	applicationset/observability \
	applicationset/storage \
	applicationset/media
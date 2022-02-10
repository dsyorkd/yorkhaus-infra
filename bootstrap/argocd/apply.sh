#!/bin/sh


echo "Deploying argocd"
helm template \
    --include-crds \
    --namespace argocd \
    argocd . \
    | kubectl apply -n argocd -f -

echo "Waiting..."
kubectl -n argocd wait --timeout=60s --for condition=Established \
       crd/applications.argoproj.io \
       crd/applicationsets.argoproj.io

echo "done. \n"
echo "logging in to argocd"

passwd = kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

argocd login rancher.twistedlife.space/argocd/ --username admin --password $passwd


argocd cluster add twisted-cluster

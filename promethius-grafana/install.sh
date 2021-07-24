#!/usr/bin/env bash
#helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
#helm repo add stable https://kubernetes-charts.storage.googleapis.com/
#helm repo add grafana https://grafana.github.io/helm-charts
#helm repo update

# uninstall
#helm uninstall prometheus --namespace=monitoring
#helm uninstall grafana --namespace=monitoring
##

kubectl create namespace monitoring

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add stable https://kubernetes-charts.storage.googleapis.com/
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

# todo: need to add these files to the cluster creation docker image (remove absolute file pathes
#helm install -f /Users/James.Kieley/git/thesis-kube-nfs/kubernetes/scaling-overflower/cluster-creation-scripts/promethius-grafana/promethius-values.yaml prometheus prometheus-community/prometheus --namespace=monitoring
#helm install -f /Users/James.Kieley/git/thesis-kube-nfs/kubernetes/scaling-overflower/cluster-creation-scripts/promethius-grafana/grafana-values.yaml grafana grafana/grafana --namespace=monitoring

helm install -f /app/promethius-values.yaml prometheus prometheus-community/prometheus --namespace=monitoring
helm install -f /app/grafana-values.yaml grafana grafana/grafana --namespace=monitoring
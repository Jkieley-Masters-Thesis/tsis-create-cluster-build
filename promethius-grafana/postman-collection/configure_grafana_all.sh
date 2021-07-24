export GRAFANA_HOST=localhost:3000
export GRAFANA_PASS=*******************************
bash /Users/James.Kieley/git/thesis-kube-nfs/kubernetes/scaling-overflower/cluster-creation-scripts/promethius-grafana/postman-collection/create_datasource.sh
bash /Users/James.Kieley/git/thesis-kube-nfs/kubernetes/scaling-overflower/cluster-creation-scripts/promethius-grafana/postman-collection/create_cluster_dashboard.sh
bash /Users/James.Kieley/git/thesis-kube-nfs/kubernetes/scaling-overflower/cluster-creation-scripts/promethius-grafana/postman-collection/create_kubernetes_dashboard.sh
bash /Users/James.Kieley/git/thesis-kube-nfs/kubernetes/scaling-overflower/cluster-creation-scripts/promethius-grafana/postman-collection/create_pod_dashboard.sh
bash /Users/James.Kieley/git/thesis-kube-nfs/kubernetes/scaling-overflower/cluster-creation-scripts/promethius-grafana/postman-collection/node_exporter_dashboard.sh
curl --location --request POST "http://$GRAFANA_HOST/api/dashboards/db" \
-u admin:$GRAFANA_PASS \
--header 'Content-Type: application/json' \
--data-binary "@/Users/James.Kieley/git/thesis-kube-nfs/kubernetes/scaling-overflower/cluster-creation-scripts/promethius-grafana/postman-collection/node_exporter_dashboard.json"
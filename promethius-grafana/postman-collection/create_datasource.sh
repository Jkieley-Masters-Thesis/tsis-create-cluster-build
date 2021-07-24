curl --location --request POST "http://$GRAFANA_HOST/api/datasources" \
-u admin:$GRAFANA_PASS \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "Prometheus-1",
    "type": "prometheus",
    "access": "proxy",
    "url": "http://prometheus-server",
    "isDefault": true,
    "jsonData": {
        "timeInterval": "2"
    }
}'
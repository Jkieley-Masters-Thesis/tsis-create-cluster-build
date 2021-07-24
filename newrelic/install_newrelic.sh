helm repo add newrelic https://helm-charts.newrelic.com
helm install newrelic-bundle newrelic/nri-bundle \
 --set global.licenseKey=3a277bac1ee1e62ec10bede94eb680b14feae634 \
 --set global.cluster=test-cluster \
 --namespace=default \
 --set newrelic-infrastructure.privileged=true \
 --set ksm.enabled=true \
 --set prometheus.enabled=true \
 --set kubeEvents.enabled=true \
 --set logging.enabled=true
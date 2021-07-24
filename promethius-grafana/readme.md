# Local Rereqs
## Install helm
```bash
brew install helm
```
- https://helm.sh/docs/intro/install/

## Install Promethius
- https://github.com/prometheus-community/helm-charts

### Install Repo
```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
```
```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add stable https://kubernetes-charts.storage.googleapis.com/
helm repo update
```

### Install Chart
```
# helm install 11.15.0 prometheus-community/prometheus # did not work
helm install prometheus-community/prometheus --generate-name
```

### Example Successful Output
```
NAME: prometheus-1600655056
LAST DEPLOYED: Sun Sep 20 19:24:18 2020
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
The Prometheus server can be accessed via port 80 on the following DNS name from within your cluster:
prometheus-1600655056-server.default.svc.cluster.local


Get the Prometheus server URL by running these commands in the same shell:
  export POD_NAME=$(kubectl get pods --namespace default -l "app=prometheus,component=server" -o jsonpath="{.items[0].metadata.name}")
  kubectl --namespace default port-forward $POD_NAME 9090


The Prometheus alertmanager can be accessed via port 80 on the following DNS name from within your cluster:
prometheus-1600655056-alertmanager.default.svc.cluster.local


Get the Alertmanager URL by running these commands in the same shell:
  export POD_NAME=$(kubectl get pods --namespace default -l "app=prometheus,component=alertmanager" -o jsonpath="{.items[0].metadata.name}")
  kubectl --namespace default port-forward $POD_NAME 9093
#################################################################################
######   WARNING: Pod Security Policy has been moved to a global property.  #####
######            use .Values.podSecurityPolicy.enabled with pod-based      #####
######            annotations                                               #####
######            (e.g. .Values.nodeExporter.podSecurityPolicy.annotations) #####
#################################################################################


The Prometheus PushGateway can be accessed via port 9091 on the following DNS name from within your cluster:
prometheus-1600655056-pushgateway.default.svc.cluster.local


Get the PushGateway URL by running these commands in the same shell:
  export POD_NAME=$(kubectl get pods --namespace default -l "app=prometheus,component=pushgateway" -o jsonpath="{.items[0].metadata.name}")
  kubectl --namespace default port-forward $POD_NAME 9091

For more information on running Prometheus, visit:
https://prometheus.io/
```

# Open Promethius Graph Query Web UI
```
kubectl port-forward prometheus-1600206966-server-75f66ccd57-5nl97 7000:9090
open http://localhost:7000
```

# install Grafana
- https://hub.helm.sh/charts/grafana/grafana

```
helm repo add grafana https://grafana.github.io/helm-charts
helm install grafana/grafana --generate-name
```
## example successful output
```bash
Outbound_Model_1.2_sub1$ helm install grafana/grafana --generate-name
NAME: grafana-1600654832
LAST DEPLOYED: Sun Sep 20 19:20:34 2020
NAMESPACE: default
STATUS: deployed
REVISION: 1
NOTES:
1. Get your 'admin' user password by running:

   kubectl get secret --namespace default grafana-1600654832 -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

2. The Grafana server can be accessed via port 80 on the following DNS name from within your cluster:

   grafana-1600654832.default.svc.cluster.local

   Get the Grafana URL to visit by running these commands in the same shell:

     export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=grafana,app.kubernetes.io/instance=grafana-1600654832" -o jsonpath="{.items[0].metadata.name}")
     kubectl --namespace default port-forward $POD_NAME 3000

3. Login with the password from step 1 and the username: admin
#################################################################################
######   WARNING: Persistence is disabled!!! You will lose your data when   #####
######            the Grafana pod is terminated.                            #####
#################################################################################
```

# open Grafana dashboard
username: admin

password: 
```
kubectl get secret --namespace default grafana-1600207586 -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```

## add promethius as a data source
Home > add Data source.

No authentication required.
    
    Http://{service-name}:{service-port}
    ex: prometheus-1600206966-server:80
    kubectl get service --all-namespaces

### Import Grafana dashboard
search for existing cool dashboard
- https://grafana.com/grafana/dashboards?orderBy=name&direction=asc

instructions
- https://grafana.com/docs/grafana/latest/reference/export_import/

# dashboard I like
- https://grafana.com/grafana/dashboards/5573
- https://grafana.com/grafana/dashboards/315 
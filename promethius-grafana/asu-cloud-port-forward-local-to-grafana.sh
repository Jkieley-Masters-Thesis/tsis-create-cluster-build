export KUBECONFIG=/Users/james_kieley/git/thesis-kube-keys/kube_config
function grafana_port_forward(){
  export POD_NAME=$(kubectl get pods --namespace monitoring -l "app.kubernetes.io/name=grafana,app.kubernetes.io/instance=grafana" -o jsonpath="{.items[0].metadata.name}")
  while true; do kubectl --namespace monitoring port-forward $POD_NAME 3002:3000; done
  # due to the 5min timeout, we perform this in a loop
  # more information here: https://stackoverflow.com/questions/47484312/kubectl-port-forwarding-timeout-issue
}

grafana_port_forward
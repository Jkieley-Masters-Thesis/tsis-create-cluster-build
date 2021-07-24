
function promethius_port_forward(){
  export POD_NAME=$(kubectl get pods --namespace monitoring -l app=prometheus,component=server -o jsonpath="{.items[0].metadata.name}")
  while true; do kubectl --namespace monitoring port-forward $POD_NAME 9090; done
  # due to the 5min timeout, we perform this in a loop
  # more information here: https://stackoverflow.com/questions/47484312/kubectl-port-forwarding-timeout-issue
}

promethius_port_forward
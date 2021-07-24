

do_it_all(){
  curl -X POST -H 'Content-type: application/json' --data '{"text":"Cluster creation is starting"}' https://hooks.slack.com/services/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
  echo "#################### $(date) - start cluster creation ####################"
  bash ./init-cluster/create_cluster.sh

  echo "#################### $(date) - start add docker creds to cluster ####################"
  bash ./init-cluster/add_docker_creds.sh

#  echo "#################### $(date) - fetch ip address of node ####################"
  bash ./init-cluster/write_ip.sh

#  echo "#################### $(date) - enable ssh with root & create upload dir ####################"
  bash ./init-cluster/update_key_mkdir_master.sh

  echo "#################### $(date) - install promethius and  grafana ####################"
  bash ./promethius-grafana/install.sh

# todo: figure out how to get his working properly
# echo  "get grafana assword"
# bash ./promethius-grafana/get-grafana-pass.sh

#  echo "create grafana dashboards"
# to be re-added after we can expose grafana and promethius publicly
# echo "#################### $(date) - create grafana dashboards ####################"
# bash ./promethius-grafana/postman-collection/create_datasource.sh
# bash ./promethius-grafana/postman-collection/create_pod_dashboard.sh
# bash ./promethius-grafana/postman-collection/create_cluster_dashboard.sh

curl -X POST -H 'Content-type: application/json' --data '{"text":"Cluster creation is complete"}' https://hooks.slack.com/services/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
}
# don't forget to init nvm; ex: "load_nvm"
do_it_all #| gnomon --type=elapsed-total
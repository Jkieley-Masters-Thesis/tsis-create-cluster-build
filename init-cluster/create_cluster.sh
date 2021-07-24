#!/usr/bin/env bash

create_cluster(){
  echo "#################### $(date) - Begin create cluster ####################"
  echo "#################### $(date) - NAME: ${NAME} ####################"
  echo "#################### $(date) - KOPS_STATE_STORE: ${KOPS_STATE_STORE} ####################"
  echo "#################### $(date) - CLUSTER_NODE_INSTANCE_TYPE: ${CLUSTER_NODE_INSTANCE_TYPE} ####################"
  echo "#################### $(date) - AWS_ZONE: ${AWS_ZONE} ####################"

  kops create cluster \
  --node-count 1 \
  --node-size $CLUSTER_NODE_INSTANCE_TYPE \
  --master-size t2.medium \
  --zones=$AWS_ZONE \
  $NAME

#   may need to add another kops validate here, looks like it's possible for rolling-update to execute before the cluster is ready and cause issues.
  kops validate cluster --name $NAME --wait 10m --count 3

  # kops create secret --name $NAME sshpublickey admin -i ~/.ssh/id_rsa.pub
  echo "#################### $(date) - update cluster with ssh key file ####################"
  kops create secret --name $NAME sshpublickey admin -i $KEY_FILE_LOC
  kops update cluster $NAME --yes
  kops rolling-update cluster $NAME --yes
  kops validate cluster --wait 10m --count 3
}

create_cluster
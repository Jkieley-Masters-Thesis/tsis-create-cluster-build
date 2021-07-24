[[ -z "${OPERATION}" ]] && echo "OPERATION was not set, exiting..." && exit || echo "OPERATION variable is set"
[[ -z "${NAME}" ]] && echo "NAME was not set, exiting..." && exit || echo "NAME variable is set"
[[ -z "${KOPS_STATE_STORE}" ]] && echo "KOPS_STATE_STORE was not set, exiting..." && exit || echo "KOPS_STATE_STORE variable is set"

if [ "$OPERATION" = "create" ]; then
  [[ -z "${AWS_ACCESS_KEY_ID}" ]] && echo "AWS_ACCESS_KEY_ID was not set, exiting..." && exit || echo "AWS_ACCESS_KEY_ID variable is set"
  [[ -z "${AWS_SECRET_ACCESS_KEY}" ]] && echo "AWS_SECRET_ACCESS_KEY was not set, exiting..." && exit || echo "AWS_SECRET_ACCESS_KEY variable is set"
  [[ -z "${AWS_REGION}" ]] && echo "AWS_REGION was not set, exiting..." && exit || echo "AWS_REGION variable is set"
  [[ -z "${AWS_ZONE}" ]] && echo "AWS_ZONE was not set, exiting..." && exit || echo "AWS_ZONE variable is set"
  [[ -z "${DOCKER_SERVER}" ]] && echo "DOCKER_SERVER was not set, exiting..." && exit || echo "DOCKER_SERVER variable is set"
  [[ -z "${DOCKER_USERNAME}" ]] && echo "DOCKER_USERNAME was not set, exiting..." && exit || echo "DOCKER_USERNAME variable is set"
  [[ -z "${DOCKER_PASS}" ]] && echo "DOCKER_PASS was not set, exiting..." && exit || echo "DOCKER_PASS variable is set"
  [[ -z "${DOCKER_EMAIL}" ]] && echo "DOCKER_EMAIL was not set, exiting..." && exit || echo "DOCKER_EMAIL variable is set"
  [[ -z "${CLUSTER_NODE_INSTANCE_TYPE}" ]] && echo "CLUSTER_NODE_INSTANCE_TYPE was not set, exiting..." && exit || echo "CLUSTER_NODE_INSTANCE_TYPE variable is set"


  echo "#################### $(date) - configure aws ####################"
#  aws configure set default.region ${AWS_REGION}
#  aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}
#  aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}
  aws ec2 describe-instances --output json # todo: This can produce output that is too long (enters vim editor for the)

  echo "#################### $(date) - generate ssh key for notes ####################"
  ssh-keygen -t rsa -q -f "/root/.ssh/id_rsa" -N ""
  export KEY_FILE_LOC="/root/.ssh/id_rsa.pub"

  echo "#################### $(date) - upload ssh key to s3 ####################"
  aws s3 cp /root/.ssh/id_rsa s3://thesis-cluster-creation/id_rsa
  aws s3 cp /root/.ssh/id_rsa.pub s3://thesis-cluster-creation/id_rsa.pub

  bash ./create_cluster.sh

  aws s3 cp $HOME/.kube/config s3://thesis-cluster-creation/kube_config

elif [[ "$OPERATION" = "destroy" ]]; then
  bash ./delete_cluster.sh
else
    echo "no recognized operation ${1}"
fi
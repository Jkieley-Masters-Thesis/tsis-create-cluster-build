#https://docs.aws.amazon.com/cli/latest/reference/ec2/create-volume.html
aws ec2 create-volume \
--region=us-west-2 \
--availability-zone=us-west-2a \
--size=2 \
--volume-type=gp2 \
--tag-specifications 'ResourceType=volume,Tags=[{Key=KubernetesCluster,Value=myfirstcluster.k8s.local}]'
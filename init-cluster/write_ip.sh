aws ec2 describe-instances --region=$AWS_REGION \
| jq '.Reservations[].Instances[] | {PrivateDnsName: .PrivateDnsName, PublicIpAddress: .PublicIpAddress, Tags: .Tags, State: .State.Name}' \
| jq -s . \
| jq '.[] | select(.State == "running")' \
| jq -s . \
| jq '.[] | select(.Tags[] | .Key == "kops.k8s.io/instancegroup" and .Value == "nodes")' \
| jq '.PublicIpAddress' \
| sed 's/"//g' > ip-address.txt
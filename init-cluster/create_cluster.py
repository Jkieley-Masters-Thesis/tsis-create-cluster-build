import logging
import os
import sys
import os

from pclusterutils import ExecuteUtil
import GlobalUtil
from pclusterutils import LogUtil
LogUtil.config_loggin("create_cluster.log")

dirname = os.path.dirname(os.path.realpath(__file__))
ExecuteUtil.execute_cwd("./create_cluster.sh", dirname)
ExecuteUtil.execute_cwd("./add_docker_creds.sh", dirname)


# Get Node Names
node_names = ExecuteUtil.execute("kubectl get no")

# Get IP Addresses of Nodes
node_ips = ExecuteUtil.execute("aws ec2 describe-instances --region=us-west-2 | jq '.Reservations[].Instances[] | {PrivateDnsName: .PrivateDnsName, PublicIpAddress: .PublicIpAddress}'")

# Create Volume Dir for file inputs to jobs
ip_address = ""
ExecuteUtil.execute_cwd(f"export IP_ADDRESS={ip_address} && ./update_key_mkdir_master.sh", dirname)

#

logging.info("Done All!")

IP_ADDRESS=`cat ip-address.txt`
INPUT_BASEP=/app/init-cluster/


enable_root_mkdir(){ # still a work in progress, neeed to execute a list of commands as root.
# possible solution scp bash script
# execute a single command that executes the bash script with root privileges
ssh ubuntu@$IP_ADDRESS << EOF
    sudo chmod u+x /home/ubuntu/update_key_mkdir.sh
    sudo su root -c "bash -c /home/ubuntu/update_key_mkdir.sh"
EOF
}

echo "#################### $(date) - add key to avoid known host interactive prompt ####################"
ssh-keyscan -t rsa -H $IP_ADDRESS >> ~/.ssh/known_hosts

echo "#################### $(date) - scp script to host: ${IP_ADDRESS} ####################"
scp $INPUT_BASEP/update_key_mkdir.sh ubuntu@$IP_ADDRESS:/home/ubuntu/

echo "#################### $(date) - execute script remotley to enable ssh via root ####################"
enable_root_mkdir

echo "#################### $(date) - ssh via root enabled ####################"

echo "#################### $(date) - scp data files via root enabled ####################"
aws s3 cp s3://thesis-cluster-creation/10082018_export.csv /app/
aws s3 cp s3://thesis-cluster-creation/credit-fraud-dealing-with-imbalanced-datasets.ipynb /app/
aws s3 cp s3://thesis-cluster-creation/credit-fraud-dealing-with-imbalanced-datasets.nbconvert.ipynb /app/
aws s3 cp s3://thesis-cluster-creation/creditcard_large.csv /app/
aws s3 cp s3://thesis-cluster-creation/export_09292018.csv /app/

scp /app/10082018_export.csv ubuntu@$IP_ADDRESS:/to-mount-data-dir
scp /app/credit-fraud-dealing-with-imbalanced-datasets.ipynb ubuntu@$IP_ADDRESS:/to-mount-data-dir
scp /app/credit-fraud-dealing-with-imbalanced-datasets.nbconvert.ipynb ubuntu@$IP_ADDRESS:/to-mount-data-dir
scp /app/creditcard_large.csv ubuntu@$IP_ADDRESS:/to-mount-data-dir
scp /app/export_09292018.csv ubuntu@$IP_ADDRESS:/to-mount-data-dir
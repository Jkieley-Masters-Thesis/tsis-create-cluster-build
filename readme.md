# Reasons why you want this to run locally
- It sets local kubectl context to point to cluster
- It persists all the needed keys to point to cluster

# Steps needed to Run in docker
- [x] install helm v3.3.1
- [x] install kubectl
- [x] install scp 
- [x] install ssh
- [x] install jq v1.6
- [x] install aws creds / set through environment variables
- [x] set docker creds aws creds / set through environment variables
- [ ] mount docker volume to use a given ssh 
- [ ] automatically add new SSL cert from aws ec2 to known host to bypass interactive trust host message

# Perform All Steps to Create and Prepare Cluster
- we're very close to writing a script that does it all!
```bash  
./create_cluster.sh  
./add_docker_creds.sh  
./write_ip.sh
./update_key_mkdir_master.sh  
./promethius-grafana/install.sh
nohup ./promethius-grafana/port-forward-local-to-promethius.sh&  
nohup ./promethius-grafana/port-forward-local-to-grafana.sh&
./promethius-grafana/open-local-grafana-url.sh  
./promethius-grafana/open-local-promethius-url.sh  
```  

 1. Create Cluster  
 2. Get IP Address of non-master node
 3. Add Credentials to private docker image repository
 4. Enable SSH via Root, and create a folder to recieve files
 5. Install Promethius and Grafana
 6. Port Forward from local to remove Promethius and Grafana
 7. Open local ports for Promethius and Grafana
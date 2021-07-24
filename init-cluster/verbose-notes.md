# Notes Get IP Address of non-master node
```  
kubectl get no  
```  
#### Example Result  
```  
NAME                                          STATUS   ROLES    AGE     VERSION  
ip-172-20-32-90.us-west-2.compute.internal    Ready    master   3h17m   v1.18.8  
ip-172-20-51-172.us-west-2.compute.internal   Ready    node     3h16m   v1.18.8  
ip-172-20-58-113.us-west-2.compute.internal   Ready    node     3h16m   v1.18.8  
```  
## Get Public Ip Address  
```  
aws ec2 describe-instances --region=us-west-2 >> ec2.json  
```  
see maping between  
```  
Reservations[0].Instances[0].PrivateDnsName  
Reservations[0].Instances[0].PublicIpAddress  
```  
  
```  
aws ec2 describe-instances --region=us-west-2 | jq '.Reservations[].Instances[] | {PrivateDnsName: .PrivateDnsName, PublicIpAddress: .PublicIpAddress}'  
```  
```  
{  
 "PrivateDnsName": "ip-172-20-51-172.us-west-2.compute.internal", "PublicIpAddress": "54.188.253.79"}  
{  
 "PrivateDnsName": "ip-172-20-58-113.us-west-2.compute.internal", "PublicIpAddress": "35.166.60.54"}  
{  
 "PrivateDnsName": "ip-172-20-32-90.us-west-2.compute.internal", "PublicIpAddress": "34.221.8.98"}  
  
```  
  
# Notes Create a Folder To Recieve Files  
" 0755 permissions with owner being kubelet user"  

## Looks like the kubelet user is root  
```  
ubuntu@ip-172-20-51-172:/$ ps -aux | grep kubelet  
root        6622  1.6  2.6 1364572 107100 ?      Ssl  17:18   4:14 /usr/local/bin/kubelet --anonymous-auth=false --cgroup-root=/ --client-ca-file=/srv/kubernetes/ca.crt --cloud-provider=aws --cluster-dns=100.64.0.10 --cluster-domain=cluster.local --enable-debugging-handlers=true --eviction-hard=memory.available<100Mi,nodefs.available<10%,nodefs.inodesFree<5%,imagefs.available<10%,imagefs.inodesFree<5% --hostname-override=ip-172-20-51-172.us-west-2.compute.internal --kubeconfig=/var/lib/kubelet/kubeconfig --network-plugin-mtu=9001 --network-plugin=kubenet --non-masquerade-cidr=100.64.0.0/10 --pod-infra-container-image=k8s.gcr.io/pause-amd64:3.2 --pod-manifest-path=/etc/kubernetes/manifests --register-schedulable=true --resolv-conf=/run/systemd/resolve/resolv.conf --v=2 --volume-plugin-dir=/usr/libexec/kubernetes/kubelet-plugins/volume/exec/ --cni-bin-dir=/opt/cni/bin/ --cni-conf-dir=/etc/cni/net.d/  
ubuntu     66449  0.0  0.0   8160  2504 pts/0    S+   21:44   0:00 grep --color=auto kubelet  
```  
#ssh in ```  
ssh ubuntu@54.188.253.79  
```  
# create dir  
```  
sudo mkdir /to-mount-data-dir  
```  
  
# setting up host mount  
- https://kubernetes.io/docs/concepts/storage/volumes/#hostpath  
  
# watch events for a sepcific pod  
```  
kubectl get event --namespace default --field-selector involvedObject.name=credit-card-fraud-detection-cnns-xw4wg  
```  
- https://stackoverflow.com/questions/51931113/kubectl-get-events-only-for-a-pod
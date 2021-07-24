deploy:
	kubectl apply -f ./test-ebs-pod.yaml
undeploy:
	kubectl delete -f ./test-ebs-pod.yaml --force=true
install-mon:
	./promethius-grafana/install.sh
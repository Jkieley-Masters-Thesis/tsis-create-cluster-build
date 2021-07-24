#!/usr/bin/env bash
kubectl create secret docker-registry regcred \
--docker-server="docker.io" \
--docker-username="jkieley" \
--docker-password="004fd3d6-58ad-4dd1-967a-4ffb76429e90" \
--docker-email="jkieley@asu.edu"

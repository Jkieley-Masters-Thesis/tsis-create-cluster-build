#!/usr/bin/env bash

kubectl get no
aws ec2 describe-instances --region=us-west-2 | jq '.Reservations[].Instances[] | {PrivateDnsName: .PrivateDnsName, PublicIpAddress: .PublicIpAddress}'
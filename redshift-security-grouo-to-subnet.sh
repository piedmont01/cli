#!/bin/sh

for each in `aws redshift describe-cluster-security-groups --profile famc-legacy --region us-east-1 | jq .ClusterSecurityGroups[].IPRanges[].CIDRIP | sed 's/\"//g'`
do
	aws ec2 authorize-security-group-ingress  --group-id  sg-0cd53f42a1b20ec7a   --protocol tcp --port 5439  --cidr $each --profile famc-legacy --region us-east-1
done

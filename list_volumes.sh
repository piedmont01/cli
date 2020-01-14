#!/bin/sh

PROFILE_LIST="famc-legacy famc-dev famc-qa famc-prod famc-ops famc-imaging-prod"

let count=0
for prfile in $PROFILE_LIST
do
  gimme-aws-creds --profile $prfile
  aws ec2 describe-volumes --profile $prfile --region us-east-1 --query Volumes[].VolumeId
done

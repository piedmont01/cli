#!/bin/sh

gimme-aws-creds --profile $1


echo $1
for each in `cat $2 | grep vol`
do
  echo $each
  aws ec2 describe-volumes --output text  --filter "Name=volume-id , Values=$each" --profile $1 --region us-east-1
done

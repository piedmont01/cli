#!/bin/sh

for inst in i-cc1bb29c	i-b93b1b97	i-c5c23795	i-ba8ff49a	i-0cd78e5f	i-7337829e	i-094135e6	i-234a34dc	i-9e14bb6e	i-4e1d82be	i-b0421d40	i-00c4a3d7	i-42cea995	i-d6bf5d00	i-c2826014	i-8ee16827	i-1578acbd	i-561285e1	i-3f2fe689	i-e9df5b60	i-13334f9a	i-fb74df7f	i-7575a1f2	i-bf29a23c	i-9dea6f8b	i-0a12c96269ae45db0
do
  echo $inst
  aws ec2 describe-volumes --filter "Name=attachment.instance-id , Values=$inst" --profile famc-legacy --region us-east-1 --query Volumes[].VolumeId
done

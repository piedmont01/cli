#!/bin/sh

PROFILE_LIST="famc-dev famc-qa famc-prod famc-imaging-prod famc-legacy famc-ops"
for profile in $PROFILE_LIST
do
	for bucket in `aws s3api list-buckets --profile $profile  --query Buckets[].Name --output text`
	do
		echo $bucket
		aws s3api put-bucket-encryption --bucket $bucket  --server-side-encryption-configuration  '{"Rules": [{"ApplyServerSideEncryptionByDefault": {"SSEAlgorithm": "AES256"}}]}' --profile $profile
	done
done

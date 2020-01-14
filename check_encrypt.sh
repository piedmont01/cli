#!/bin/sh

# Dev 557027395202
# Legacy 858737304353
# QA 693538057230
# Prod 926668386439
# Ops 647523064133
# Imaging Prod 097856158272

PROFILE_LIST='famc-dev famc-prod famc-imaging-prod famc-ops famc-qa famc-legacy' 



for profile in $PROFILE_LIST
do
	gimme-aws-creds --profile $profile

	for i in `aws s3 ls --profile $profile | awk '{ print $3 }'`
		do
			aws s3api get-bucket-encryption --bucket $i --profile $profile
	done
done


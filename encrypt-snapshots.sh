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
	
	case $profile in
		famc-dev)
			account="557027395202"
			aws ec2 describe-snapshots --query Snapshots[].SnapshotId  --filters Name=owner-id,Values=$account --profile $profile --region us-east-1 
			;;
		famc-prod)
			account="926668386439"
			aws ec2 describe-snapshots --query Snapshots[].SnapshotId  --filters Name=owner-id,Values=$account --profile $profile --region us-east-1 
			;;
		famc-imaging-prod)
			account="097856158272"
			aws ec2 describe-snapshots --query Snapshots[].SnapshotId  --filters Name=owner-id,Values=$account --profile $profile --region us-east-1 
			;;
	  	famc-ops)
			account="647523064133"
			aws ec2 describe-snapshots --query Snapshots[].SnapshotId  --filters Name=owner-id,Values=$account --profile $profile --region us-east-1 
			;;
		famc-qa)
			account="693538057230"
			aws ec2 describe-snapshots --query Snapshots[].SnapshotId  --filters Name=owner-id,Values=$account --profile $profile --region us-east-1 
			;;
		famc-legacy)
			account="858737304353"
			aws ec2 describe-snapshots --query Snapshots[].SnapshotId  --filters Name=owner-id,Values=$account --profile $profile --region us-east-1 
			;;
	esac
done

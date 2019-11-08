#!/bin/sh

# list of AWS profiles to process
PROFILE_LIST="famc-dev famc-imaging-prod famc-legacy famc-ops famc-qa famc-prod"

for profile in $PROFILE_LIST
do
	# name of bucket to upload functions to
	BUCKET_NAME="lambda-backup-$profile-11072019"

        echo $profile
	
	# make a directory for downloaded files if it doesn't exist
	if [ ! -d "$profile" ]
	then
	        mkdir $profile
	fi

	# obtain MFA token
	gimme-aws-creds --profile $profile

	# traverse all functions in AWS account
	for funct in `aws lambda list-functions --profile $profile --region us-east-1  | jq .Functions[].FunctionName | sed 's/\"//g'`
	do
		# create a file name which includes the function name, the runtime and the last modified time
		zip_file=`aws lambda get-function --function-name $funct --region us-east-1 --profile $profile --query 'Configuration.[ FunctionName, Runtime , LastModified] | join(\`, \`, to_array(to_string(@))) '  --output text | sed 's/\[//;s/\]//;s/"//g;s/,/-/g;s/$/.zip/'`

		# obtain the name of the URL where the function resides 
		url_location=`aws lambda get-function --function-name $funct --region us-east-1 --profile $profile  --query Code.Location --output text`
		
		# download the function to appropriate folder
		wget $url_location -o $profile/$zip_file

		# copy the downloaded file to appropriate S3 bucket
		aws s3 cp $profile/$zip_file s3://$BUCKET_NAME/$zip_file --profile $profile
	done
done

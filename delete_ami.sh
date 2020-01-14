#!/bin/bash
amiid=`aws ec2 describe-images –filter Name=tag:amitype,Values=autoscale –output text | grep -i ami | awk ‘{ print $5, $7 }’ | awk ‘NR==1{print $1}’`
time=`aws ec2 describe-images –image-ids $amiid –query ‘Images[*].[ImageId,CreationDate]’ –output text | awk ‘{ print $2 }’`

time1=`echo $time | head -c 10`

compdate=`date ‘+%y-%m-%d’ –date=’7 days ago’`

flag=$(echo $(( ( $(date -ud $time1 +’%s’) – $(date -ud $compdate +’%s’) )/60/60/24 )))
echo “flag=$flag”
if [[ “$flag” -gt 7 ]];
then
my_array=( $(aws ec2 describe-images –image-ids $amiid –output text –query ‘Images[*].BlockDeviceMappings[*].Ebs.SnapshotId’) )
echo “my_array=$my_array”
echo “older than 7 days”;


echo “deregistering old image $amiid”
aws ec2 deregister-image –image-id $amiid

echo “my_array=$my_array”
my_array_length=${#my_array[@]}
echo “Removing Snapshot”
for (( i=0; i<$my_array_length; i++ ))

echo “Removing Snapshot”
for (( i=0; i<$my_array_length; i++ ))
do
temp_snapshot_id=${my_array[$i]}
echo “Deleting Snapshot: $temp_snapshot_id”
aws ec2 delete-snapshot –snapshot-id $temp_snapshot_id
done
fi

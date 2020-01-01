#!/bin/bash
# If the ec2 instances file exists, remove it
#if [ -f ec2-instances.out ];
#then
#  rm -f ec2-instances.out
#fi

#List Instances In Each Region.
for region in $(aws ec2 describe-regions --output text | cut -f4)
do
     echo "Region is - " $region
     INSTANCE_IDS=$(aws ec2 describe-instances --filters Name=instance-state-name,Values=running --region "$region" --output text --query 'Reservations[*].Instances[*].[InstanceId]')
     echo "Instance ID - " $INSTANCE_ID
     for INSTANCE_ID in ${INSTANCE_IDS}
     do
       echo $INSTANCE_ID
       # Terminate the EC2 instances on the basis of Region
       aws ec2 terminate-instances --instance-ids $INSTANCE_ID --region $region
       INSTANCE_ID=""
     done
done

# cat ec2-instances.out | cut -f2 | while read INSTANCE_ID
# do
#         echo "Instance ID - " $INSTANCE_ID
# done

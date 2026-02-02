#!/bin/bash

SG_ID=
AMI_ID=
ZONE_ID=
DOMAIN_NAME="tehith.online"

for instance in $@
do
    INSTANCE_ID=$(aws ec2 run-instances \
    --image-id $AMI_ID \
    --instance-type "t3.micro" \
    --security-group $SG_ID \
    --tag-specifications "ResourceType=instances, Tags=[{Key=Name,Value=$instance}]" \
    --query 'Instances[0].InstanceId' \
    --output text)

    if [ $instance=="frontend" ]; then
        IP=$(
            aws ec2 describe-instances \
            --instance-ids $INSTANCE_ID \
            --query 'Reservations[].Instances[].PublicIpAddress' \
            --output text
        )
        RECORD_NAME="$DOMAIN_NAME" #tehith.online
    else
        IP=$(
            aws ec2 describe-instances \
            --instance-ids $INSTANCE_ID \
            --query 'Reservations[].Instances[].PrivateIpAddress' \
            --output text
        )
        RECORD_NAME="$instance.$DOMAIN_NAME" #mongodb.tehith.online
    fi

    echo "IP Address: $IP"

    aws route53 change-resource-record-sets \
    --hosted-zone-id $ZONE_ID \
    --change-batch '
    {
        "Comment": "Updating Record",
        "Changes":[
            {
                "Action":"UPSERT"
                "ResourceRecordSet":{
                    "Name": "'$RECORD_NAME'",
                    "Type": "A",
                    "TTL": 1,
                    "ResourceRecords":[
                        {
                            "Value":"'$IP'"
                        }
                    ]
                }
            }
        ]
    }
    '

    echo "Record Updated for $instance"
done
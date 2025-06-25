#!/bin/bash
LAUNCH_TEMPLATE_NAME="cdoty-launch-template"
AMI_ID="ami-000ec6c25978d5999" 
INSTANCE_TYPE="t2.micro"
KEY_NAME="cd-pleasework"
SECURITY_GROUP_ID="sg-0123456789abcdef0"
AUTO_SCALING_GROUP_NAME="cdoty-asg"
VPC_SUBNET_ID="subnet-0e2a4121d2e530e8e"

# Create launch template
aws ec2 create-launch-template \
    --launch-template-name $LAUNCH_TEMPLATE_NAME \
    --version-description "Initial version" \
    --launch-template-data "{
        \"ImageId\":\"$AMI_ID\",
        \"InstanceType\":\"$INSTANCE_TYPE\",
        \"KeyName\":\"$KEY_NAME\",
        \"SecurityGroupIds\":[\"$SECURITY_GROUP_ID\"]
    }"

# Create Auto Scaling group
aws autoscaling create-auto-scaling-group \
    --auto-scaling-group-name $AUTO_SCALING_GROUP_NAME \
    --launch-template "LaunchTemplateName=$LAUNCH_TEMPLATE_NAME,Version=1" \
    --min-size 1 \
    --max-size 3 \
    --desired-capacity 1 \
    --vpc-zone-identifier "$VPC_SUBNET_ID"
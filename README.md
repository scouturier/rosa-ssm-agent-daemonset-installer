# node-configuration-daemonset

This project shows how you can install the SSM agent onto ROSA clusters using a Kubernetes DaemonSet. 

This project was heavily inspired by Jeremy Cowan's [SSM Agent Daemonset Installer Project](https://github.com/aws-samples/ssm-agent-daemonset-installer).  

## Installation instructions
1. Add the `AmazonSSMManagedInstanceCore` policy the the EC2 Instance Profiles of the EC2 Instances.
```
export ROSA_CLUSTER_NAME="<LOWCASE ROSA CLUSTER NAME>"
export ROSA_CLUSTER_ID=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${ROSA_CLUSTER_NAME}*worker*" --query 'Reservations[0].Instances[*].{Tags:Tags[?Value == `owned`] | [0].Key}' --output text | cut -d '/' -f 3)
aws iam attach-role-policy --role-name ${ROSA_CLUSTER_ID}-master-role --policy-arn arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore
aws iam attach-role-policy --role-name ${ROSA_CLUSTER_ID}-worker-role --policy-arn arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore
```
3. Add Privileged SCC to user ssm-agent-installer
```
oc adm policy add-scc-to-user privileged -z ssm-agent-installer -n node-configuration-deamonset
```
3. Apply the manifest:
```
oc apply -f setup.yaml
```

## Verify installation
You can verify that the installation was successful by looking at the logs of a DaemonSet pod.  If the installation was successfull, the last line in the log file will read `Success` otherwise it will read `Fail`.  The nodes will also appears as managed instances in the SSM console if the installation was successful. 

Based on the EKS SSM Agent deployment: https://github.com/aws-samples/ssm-agent-daemonset-installer

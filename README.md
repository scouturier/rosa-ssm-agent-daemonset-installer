# node-configuration-daemonset

This project shows how you can install the SSM agent onto ROSA clusters using a Kubernetes DaemonSet. 

This project was heavily inspired by Jeremy Cowan's [SSM Agent Daemonset Installer Project](https://github.com/aws-samples/ssm-agent-daemonset-installer).  

## Installation instructions
1. Add the `AmazonSSMManagedInstanceCore` policy the the EC2 Instance Profiles of the EC2 Instances. 
2. Apply the manifest:
```
oc apply -f setup.yaml
```

## Verify installation
You can verify that the installation was successful by looking at the logs of a DaemonSet pod.  If the installation was successfull, the last line in the log file will read `Success` otherwise it will read `Fail`.  The nodes will also appears as managed instances in the SSM console if the installation was successful. 

Based on the EKS SSM Agent deployment: https://github.com/aws-samples/ssm-agent-daemonset-installer
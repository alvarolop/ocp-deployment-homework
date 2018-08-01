#!/bin/bash
echo ""
echo "This is the deployment automation tool"
echo ""

## VARS
SERVER_DOMAIN=alopezme-redhat.com@bastion.a3cf.example.opentlc.com
HOSTS_FILE_LOCAL=/home/alvaro/openshift-examples/openshift-deployment/hosts-template-alvaro-v1
HOSTS_FILE_DESTINATION=/home/alopezme-redhat.com/


## Initialize the openshift installation

# Copy the hosts file to the bastion
echo " - Copy the hosts file to the bastion"
#scp ${HOSTS_FILE_LOCAL} ${SERVER_DOMAIN}:${HOSTS_FILE_DESTINATION}

# SSH to the bastion and become root
echo " - SSH to the bastion"
ssh -t $SERVER_DOMAIN 'sudo echo hola && \
sudo echo k pasa'

# Copy files
#cp /home/alopezme-redhat.com/hosts-alvaro-v1 /root/

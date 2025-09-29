#!/bin/bash
TEMPLATE=9000
NEWVM=101
HOSTNAME=node1.internal
IP=192.168.100.101/24
GW=192.168.100.1
qm clone $TEMPLATE $NEWVM --name $HOSTNAME --full 0  # Linked clone
qm set $NEWVM --sshkey ~/.ssh/id_rsa.pub
qm set $NEWVM --ipconfig0 ip=$IP,gw=$GW
qm set $NEWVM --ciuser ubuntu --cipassword tempPass  # Or no password for key-only
qm start $NEWVM

#!/bin/bash
# Usage: ./generate-seed-iso.sh <hostname> <user> <ssh-key-path>
# bash script for generating base seed.iso for future deploy/config
HOSTNAME=$1
USER=$2
SSH_KEY=$(cat $3)

mkdir -p seed-iso
cat <<EOF > seed-iso/meta-data
instance-id: $HOSTNAME
local-hostname: $HOSTNAME
EOF

cat <<EOF > seed-iso/user-data
#cloud-config
hostname: $HOSTNAME
users:
  - name: $USER
    sudo: ALL=(ALL) NOPASSWD:ALL
    groups: sudo
    shell: /bin/bash
    ssh-authorized-keys:
      - $SSH_KEY
packages:
  - vim
  - net-tools
runcmd:
  - echo "Seed deployed on $(date)" >> /var/log/seed.log
EOF

genisoimage -output $HOSTNAME-seed.iso -volid cidata -joliet -rock seed-iso/user-data seed-iso/meta-data
rm -rf seed-iso
echo "Seed ISO created: $HOSTNAME-seed.iso"

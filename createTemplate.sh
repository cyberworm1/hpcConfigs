#!/bin/bash
VMID=9000  # Template ID
qm create $VMID --name ubuntu-template --memory 2048 --cores 2 --net0 virtio,bridge=vmbr0
qm importdisk $VMID /path/to/cloudimg-amd64.img local-lvm
qm set $VMID --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-$VMID-disk-0
qm set $VMID --ide2 local-lvm:cloudinit  # Add cloud-init drive
qm set $VMID --boot c --bootdisk scsi0
qm template $VMID  # Convert to template
echo "Template ready for cloning!"

# HPC Testbed Legacy Artifact (Pre-Proxmox Migration, Sept 2025)
## Overview
- **Hypervisors:** hpc (192.168.0.221, Ubuntu 22.04.5 LTS, libvirt/QEMU, Intel Xeon E5-1650 v2, 64GB RAM, 1TB SSD, dual AMD Radeon HD 7970 GPUs). hpc2 (192.168.0.222, similar setup).
- **Network:** Subnet 192.168.122.0/24, bridge "br-vm" (custom for VM isolation), domain ".internal". Static IPs on infra hosts. enp12s0 active interface.
- **Admin User:** "rick" (sudo, VIM/VI editor, SSH key at /home/rick/.ssh/id_ed25519.pub).
- **General Considerations:** Undocumented network hacks (e.g., bridge tweaks for stability). Focus on minimal security (no advanced firewalls). Ansible for automation. Test lab mindset—rebuildable.

## Services Configured
- **DNS + DHCP (dns.internal, 192.168.122.2):** Bind9 for DNS resolution (.internal domain), ISC DHCP/dnsmasq for dynamic IPs. Static reservations for key hosts. No replication/failover.
- **NTP (seiko.internal, 192.168.122.3):** Chrony server, syncing to upstream pools. Clients point here for time accuracy.
- **Ansible (ansible.internal, 192.168.122.4):** Control node with inventory, playbooks for provisioning. SSH key auth as "rick". No advanced roles.
- **NFS (nfs-depot.internal, 192.168.122.250):** Shared storage exports (/mnt/nfs). No quotas or HA.
- **Reference VM (sillytav.internal, 192.168.122.10):** SillyTavern app (low priority, optional rebuild).

## Other Considerations and Caveats
- **IP Addressing:** Ad-hoc statics (e.g., .2 for DNS); no structured schema (e.g., .1-.10 infra, .11+ compute).
- **Backups:** Ad-hoc rsync scripts for VMs (XML + qcow2 disks, checksum verified).
- **Monitoring/Security:** None formalized—add in rebuild (e.g., Prometheus/Grafana, UFW).
- **Hardware Passthrough:** GPUs for potential ML (CUDA), but unconfigured.
- **Lessons Learned:** Document everything (GitHub). Avoid single points of failure. Use containers for services where possible.
- **Migration Notes:** Disks importable to Proxmox; XML as config blueprint.

Date: Sept 29, 2025

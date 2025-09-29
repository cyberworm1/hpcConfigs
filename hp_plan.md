# HPC Testbed Fresh Start Plan (Proxmox + SLURM Build, Sept 2025)

## Overview
- **Project Goal:** Build a resilient HPC test lab from scratch, qualifying for Sr. HPC Systems Engineer at ______. Focus: Administer clusters, storage, networks; support apps; deploy Linux; document everything.
- **Hypervisors:** Proxmox VE 9.x on mox01 (192.168.0.221) and mox02 (192.168.0.222) for clustering. Hardware: Intel Xeon E5-1650 v2, 64GB RAM, 1TB SSD, dual AMD Radeon HD 7970 GPUs (for CUDA/ML).
- **Network:** 192.168.100.0/24 subnet, .internal domain. Proxmox bridges (vmbr0 for management, vmbr1 for VM traffic). Structured IPs: .2-.20 infra, .21+ compute. No legacy hacks—use bonds/VLANs for redundancy.
- **VM Base:** Minimal Ubuntu 25.04 Server (templated in Proxmox). Admin user: "rick" (sudo, VIM/VI editor, SSH keys at UNKNOWN.
- **Approach:** Fresh rebuild for scalability/HA. Services emphasize failover (replication/clustering). Add-ons: Logging (ELK), backups (Proxmox + rsync), security (UFW + Proxmox firewall), proxy (Nginx).
- **Timeline:** Weeks 3-6 for infra; SLURM next. Track in GitHub issues.

## Planned Services
- **Dual DNS + DHCP:** dns1.internal (.2), dns2.internal (.3). Bind9 with zone replication; ISC DHCP failover. Resolves .internal; dynamic/static IPs.
- **NTP:** ntp.internal (.4). Chrony server syncing to pools; all VMs/clients point here.
- **Ansible:** ansible.internal (.5). Control node with inventory/playbooks; SSH key auth for automation.
- **Dual LDAP:** ldap1.internal (.6), ldap2.internal (.7). OpenLDAP with syncrepl for user/group auth failover.
- **Monitoring:** monitor.internal (.8). Prometheus (metrics collection) + Grafana (dashboards/alerts); exporters on all nodes.
- **SQL Databases:** db1.internal (.9) to db4.internal (.12). MariaDB with Galera clustering/replication; one for monitoring, one for SLURM accounting (slurmdbd).
- **Extras:**
  - Logging: log.internal (.13). ELK stack (Elasticsearch/Logstash/Kibana) for centralized audits.
  - Backups: Proxmox-integrated + cron rsync for VMs/data.
  - Security: UFW per VM; Nginx reverse proxy for web services; self-signed certs.
  - Bastion: Optional jump host for secure access.
- **SLURM Prep:** Head node + compute clients post-infra; integrate with MariaDB, GPUs.

## Considerations
- **HA/Failover:** Replication for DNS/LDAP/SQL to mimic mission-critical redundancy (e.g., SpaceX launch ops).
- **Security:** Minimal packages; UFW rules; key-based auth. No internet-facing services.
- **Hardware Integration:** Test GPU passthrough for ML (PyTorch/CUDA).
- **Documentation:** All configs/scripts in GitHub; Ansible for reprovisioning.
- **Lessons from Legacy:** Structured IPs over ad-hoc; formal monitoring over none; containers for isolation (e.g., Docker for apps).

## To-Do List (Ordered Steps with Goals)
| Step | Description | Goal | Est. Time | Skill Tie-In |
|------|-------------|------|-----------|--------------|
| 1 | Install Proxmox on hpc/hpc2; cluster nodes. | Stable hypervisor base. | 1-2 hrs | Virtualization deployment. |
| 2 | Design IP/network schema; set up bridges. | Scalable addressing. | 30 min | Network planning. |
| 3 | Create Ubuntu VM template (minimal, SSH keys). | Reusable base. | 45 min | VM provisioning. |
| 4 | Deploy dual DNS/DHCP (replication/failover). | Resilient resolution. | 1 hr | Service HA. |
| 5 | Set up NTP server. | Time sync. | 30 min | Basics. |
| 6 | Deploy Ansible node; test playbook. | Automation ready. | 45 min | Config mgmt. |
| 7 | Stand up dual LDAP (syncrepl). | Auth failover. | 1 hr | Directory services. |
| 8 | Implement Prometheus + Grafana. | Cluster visibility. | 1 hr | Monitoring. |
| 9 | Set up MariaDB (2-4 instances, clustering). | HA data persistence. | 1-2 hrs | Databases. |
| 10 | Add logging/backups/security (ELK, rsync, UFW/Nginx). | Full resilience. | 1-2 hrs | Ops/security. |
| 11 | Test all with Ansible; document in GitHub. | Functional testbed. | 1 hr | Testing/docs. |

Artifact Compiled By: Grok HPC Mentor | Date: Sept 29, 2025

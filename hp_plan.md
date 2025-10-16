# HPC Testbed Infra Build Artifact (Proxmox + SLURM, Sept 2025)

## Overview
- **Project Goal:** Fresh Proxmox cluster toward SLURM testbed, building Sr. HPC Systems Engineer skills for SpaceX. Focus: Resilient infra with HA, security via LDAP/service accounts.
- **Hypervisors:** mox01 (192.168.0.221), mox02 (192.168.0.222) on Proxmox VE 9.x, clustered.
- **Network:** 192.168.100.0/24 subnet, .internal domain. Bridges: vmbr0 (management), vmbr1 (VM traffic).
- **VM Base:** Minimal Ubuntu 25.04 Server template (rick user, VIM/VI, SSH keys).
- **Build Order:** Proxmox > Base VM > DNS > DHCP > NTP > LDAP > Ansible > Grafana/Monitoring > SLURM > Extras > Compute Clients.
- **Security:** Service accounts in LDAP for least-privilege; UFW, key auth.
- **Repo:** https://github.com/cyberworm1/hpcConfigs.git for scripts/playbooks/docs.
- **Timeline:** 2 Weekends (~20 hours) for infra; SLURM workloads post-verification.

## Service Accounts List
Dedicated LDAP-managed accounts/groups for security/isolation. POSIX-compliant; no sudo for services.

| Service | Account Name | Group | Purpose/Privileges | Notes |
|---------|--------------|-------|--------------------|-------|
| DNS (Bind9) | dns-bind | hpc-dns | Run Bind daemon; read/write zone files. | Bind DN for replication; key auth for zone transfers. |
| DHCP (ISC) | dhcp-server | hpc-dhcp | Manage DHCP leases; read DNS for dynamic updates. | Integrated with DNS; limited to /var/lib/dhcp. |
| NTP (Chrony) | ntp-chrony | hpc-ntp | Sync time; access chronyd.sock. | No shell; runs as daemon user. |
| LDAP (OpenLDAP) | ldap-admin | hpc-ldap-admins | Admin bind for schema/replication; read/write LDIF. | Separate from user auth; use for Ansible provisioning. |
| Ansible | ansible-user | hpc-automation | SSH key auth; run playbooks across cluster. | Sudo for specific commands; inventory access. |
| Monitoring (Prometheus) | prom-user | hpc-monitoring | Collect metrics; access exporters. | Read-only on nodes; no write to storage. |
| Monitoring (Grafana) | grafana-user | hpc-monitoring | Dashboard access; query Prometheus. | Web auth; integrate with LDAP for user logins. |
| SQL (MariaDB) | db-admin | hpc-db-admins | DB management; replication setup. | Per-DB users (e.g., slurm-db for SLURM). |
| SLURM | slurm-user | hpc-slurm | Run slurmd/slurmctld; access MariaDB. | Munge auth; group for job accounting. |
| General (All) | hpc-cluster-users | hpc-users | Base group for cluster access. | Subgroups per role; LDAP filter for logins. |

## To-Do List
Ordered steps with goals; use VIM/VI for edits, minimal VMs. Step numbers will be marked with an "x" as they are completed.

| Step | Description | Goal | Est. Time | Skill Tie-In |
|------|-------------|------|-----------|--------------|
| X | Install Proxmox on mox01/mox02; cluster them. Set vmbr1 for 192.168.100.0/24. | Clustered hypervisors. | 1-2 hrs | Virtualization. |
| 2 | Create base Ubuntu 25.04 minimal VM template (SSH keys, rick user, VIM). Script clone process (Bash in GitHub). | Easy deployments. | 45 min | Templating/scripting. |
| x | Deploy dns01/dns02 (.2/.3); install Bind9, configure replication/failover, .internal domain. | Reliable resolution. | 1 hr | DNS HA. |
| x | Deploy dhcp (.4); install ISC DHCP, integrate with DNS for dynamic/static IPs (e.g., reserves for infra). | IP management. | 45 min | DHCP setup. |
| x | Deploy ntp (.5); install Chrony, sync to pools, point all VMs. | Time accuracy. | 30 min | NTP basics. |
| x | Created a 'mediawiki' server at .16 to use for internal documentation and reference | Documentation | 1 hr | Wiki Setup. | 
| / | PARTIALLY COMPLETE Deploy ldap01/ldap02 (.6/.7); CHANGED PLAN FROM OpenLDAP to FreeIPA server on rocky linux VM. FreeIPA is running and semi-functional on .6 needs replication/failover | Centralized auth. | 1 hr | LDAP failover. |
| 6.5| Check into SRV and TXT records for DNS. Work out simplification of auth binding to FreeIPA. 
| 7 | Deploy ansible (.8); install Ansible, inventory/playbooks, SSH keys. Test on dns/ntp. | Automation hub. | 45 min | Config mgmt. |
| 8 | Deploy grafana (.9) + Prometheus; install on monitor VM, exporters on all, LDAP integration. | Cluster visibility. | 1 hr | Monitoring. |
| 9 | Deploy SLURM head node (.10); install slurmctld/slurmdbd, MariaDB HA (2-4 dbs .11-.14), integrate LDAP. | Job scheduling ready. | 1-2 hrs | Resource mgmt. |
| 10 | Add extras: ELK logging (.15), backups (Proxmox + rsync cron), security (UFW/Nginx). | Full ops resilience. | 1 hr | Security/ops. |
| 11 | Verify infra with Ansible tests; document in GitHub (diagrams, playbooks). | Stable base. | 1 hr | Testing/docs. |
| 12 | Spin up 2-4 compute clients (.21+); install slurmd, test workloads (e.g., simple MPI job). | Workload testing. | 1 hr | Compute nodes. |

Artifact Compiled By: Grok HPC Mentor | Date: Sept 29, 2025

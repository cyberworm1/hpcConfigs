# hpcConfig home lab
Hi there. Thanks for stopping by.  Either you've come here randomly, or you found my link via linkedin. Either way feel free to have a look around. Once things are a bit more robust, I may open it up (by invite) to kick the tires and check my work.  If you're interested, you can email me at ------change when system is built and secure-----. 

This project isn't really anything special, just a place for me to dump config files and master plans for my internal lab, as I work through updated infra technologies. Maybe it'll help someone else out there looking for direction or a starting point on infra engineering.  

So here we are.  I took an HPC job posting from the SpaceX careers website for an HPC engineer, and converted it into a prompt with Grok/Grok Projects and have been iterating through building a test infrastructure.  Once I have a solid functional infra in place, I plan to run tests by having grok create mystery issues via script that I can use to create real world problems I'll have to investigate and solve. In a way, gamifying the training process while keeping my skills sharp.

You'll generally get a sense of the underlying platform that I am building this on, but I will share some hardware specs here (will update when I am at home and can pull the full specs):

2016 MacPro Xeon with 64GB RAM, 1TB SSD, Dual Radeon GPU (functionally useless) 1Gbps x2 Broadcom NIC
2016 MacPro Xeon with 64GB RAM, 512GB SSD, Dual Radeon GPU (functionally useless) 1Gbps x2 Broadcom NIC

I've got a couple of workstation PCs with AMD Ryzen CPUs in them, that I use as ancillary desktops for LLMs or Media generation. The larger of the two systems has an RTX 4070 and RTX 3080 side by side, while the lesser of the two PCs has an RTX 2080, that doesn't really see much use. They are "good enough" for most things, and are mentioned here as a pre-cursor to eventually being booted via USB to handle test compute loads against the GPUs in this lab environment as needed. 
All of the compute workloads will most likely be very tiny, or as a proof of concept, run at very long timelines.  This will help in verifying robustness of the system, failover, and recovery. I don't expect this system to do really awesome stuff like create an animated tv show in 6 days or solve complex rocket re-entry issues. 

Currently all Virtualization storage is local to the hosts, but I am hoping to kludge together a machine to act as a network storage device, probably running NFS.  My previous experience in this area was with VMWare vSphere environments, backed with storage, a lot of CPU cores, and even nVidia datacenter GPUs, backed with 100Gbps networking. Those were the halcyon days my friend.  But for now, we use what we've got, and for my purposes this setup is fine. 


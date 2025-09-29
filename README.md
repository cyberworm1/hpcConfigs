# hpcConfig home lab
Hi there. Thanks for stopping by.  Either you've come here randomly, or you found my link via linkedin. Either way feel free to have a look around.

This project isn't really anything special, just a place for me to dump config files and master plans for my internal lab, as I work through updated infra technologies. Maybe it'll help someone else out there looking for direction or a starting point on infra engineering.  

I currently work for a spectacular organization in Northern Indiana, with a lot of great people and great customers, but considering where I had previously been working, I'm hoping to land my next dream gig (already had one dream job at South Park Studios). 
Now, I'd really like to land a gig at SpaceX in Texas and be part of a team launching rockets to distant locations in space. 

So here we are.  I took an HPC job posting from the SpaceX careers website for an HPC engineer, and converted it into a prompt with Grok/Grok Projects and have been iterating through building a test infrastructure.  Once I have a solid functional infra in place, I plan to run tests by having grok create mystery issues via script that I can use to create real world problems I'll have to investigate and solve. In a way, gamifying the training process while keeping my skills sharp.

You'll generally get a sense of the underlying platform that I am building this on, but I will share some hardware specs here (will update when I am at home and can pull the full specs):

2016 MacPro Xeon with 64GB RAM, 1TB SSD, Dual Radeon GPU (functionally useless) 1Gbps x2 Broadcom NIC
2016 MacPro Xeon with 64GB RAM, 512GB SSD, Dual Radeon GPU (functionally useless) 1Gbps x2 Broadcom NIC

Currently all Virtualization storage is local to the hosts, but I am hoping to kludge together a machine to act as a network storage device, probably running NFS.  My previous experience in this area was with VMWare vSphere environments, backed with storage, a lot of CPU cores, and even nVidia datacenter GPUs, backed with 100Gbps networking. Those were the halcyon days my friend.  But for now, we use what we've got, and for my purposes this setup is fine. 


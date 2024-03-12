#!/usr/bin/sh

# Mount a NFS
mkdir -p /mnt/shared-dir && sudo mount -t nfs nfs:5439:/ /mnt/shared-dir

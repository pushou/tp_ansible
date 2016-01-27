#!/bin/bash
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
for net in  $(docker network ls -q);  do docker network rm $net; done

for x in $(seq 0 9); do docker network create --driver bridge br_cent_$x ;done
for x in $(seq 0 9); do docker network create --driver bridge br_deb_$x ;done

for x in $(seq 0 9); do docker run -d -p 322$x:22   --net br_cent_$x  --name  203-centos-$x --hostname 203-centos-$x  --dns=10.6.0.1 --dns-search=iutbeziers.fr   -e  AUTHORIZED_KEYS="$(cat ~/.ssh/id_rsa.pub)" registry.iutbeziers.fr/centos:7 ;done
for x in $(seq 0 9); do docker run -d -p 222$x:22   --net br_deb_$x  --name  203-debian-$x --hostname 203-debian-$x  --dns=10.6.0.1 --dns-search=iutbeziers.fr   -e  AUTHORIZED_KEYS="$(cat ~/.ssh/id_rsa.pub)" registry.iutbeziers.fr/debian:8 ;done


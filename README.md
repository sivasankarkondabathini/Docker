# Running an application as a service vs image:

if we stop and remove the container which is running the image it will stop and removes forever..

But if we run it as a service in docker cluster by mentioning replicas 1 or scale as 1 then it will create a container
with service in it either in master or slave.

Even if we try to stop and remove the service running container it will create a new container immediately
as we have setup the desired state for service as 1..so it always persist that.

Same thing applies to all scaled containers....if we setup the backup as 5 containers ..master distribute the tasks
in master and attached agents.

so deleting any one of these wl again create the tasks ...even on any failure or stop in vm's.

## Remove exited containers:
sudo docker ps -a | grep Exit | cut -d ' ' -f 1 | xargs sudo docker rm

## remove untaged images:
sudo docker rmi $(sudo docker images --filter "dangling=true" -q --no-trunc)

sudo docker rmi $(sudo docker images -a | grep "^<none>" | awk '{print $3}')


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


## AWS ECS AND ECR
ECR and ECS work independently.

ECR:
ECR can be used for a separate private docker registry
ECR repository should be created for each docker image.


ECS:
ECS maintains the cluster of EC2 instances and run the task(desired state) using docker service(swarm) mode.

Setup CICD with ECS:

From AWS, we should create the cluster and define the task defintion which points to ECR repository.
Create the service and provide the task definition with desired count. You should able to access the application.
To update the service, we should explicitly update with update-service command.
There are no triggers to update the service..like in OpenShift import-image to Image Stream updating DC..so, updating the docker image in ECR will not update the service automatically.

We should always use this:
 aws ecs update-service --service pearupweb --region eu-central-1 --cluster PearUp --desired-count 0
 aws ecs update-service --service pearupweb --region eu-central-1 --cluster PearUp --desired-count 1

Update the image in ECR, make the service desired count to 0 and update the service with original desired count.. so it will update with newly pushed image.

See Jenkinsfile2 for waituntil method to keep alive the terminal to check the updated count.
https://github.com/sivasankarkondabathini/PearUp/tree/master/PearUp.Web



Ref:

https://docs.aws.amazon.com/AWSGettingStartedContinuousDeliveryPipeline/latest/GettingStarted/CICD_Jenkins_Pipeline.html

http://www.tothenew.com/blog/how-to-automate-docker-deployments-in-aws-ecs/

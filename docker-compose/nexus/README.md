# Sonatype Nexus

## Sonatype nexus3 artifactory setup using docker-compose 

Runs in 2 containers: Nginx container serves as Reverse proxy to Nexus container

You can able to access the Nexus3 Dashboard at 80 port.

Create a Repository type Docker through Nexus Dashboard and provide the access at 5000 HTTP port, then you can able to access Private Docker Registry form any server at 5000 port. Credentials will be same as Nexus login(admin, admin123)

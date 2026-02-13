| **Port** | **Protocol/Service**        | **Default Usage**                                               | **TCP/UDP** |
| -------- | --------------------------- | --------------------------------------------------------------- | ----------- |
| 2375     | Docker API (unencrypted)    | Remote access to the Docker daemon (HTTP, not secure)           | TCP         |
| 2376     | Docker API (encrypted)      | Remote access to the Docker daemon (HTTPS, secure)              | TCP         |
| 2377     | Docker Swarm Manager        | Cluster management and orchestration                            | TCP         |
| 7946     | Docker Swarm Node Discovery | Node discovery and communication within a Docker Swarm          | TCP/UDP     |
| 4789     | Docker Overlay Network      | VXLAN traffic for container networking in Swarm mode            | UDP         |
| 443      | Docker Hub/Image Registry   | Pulling/pushing images to Docker Hub or private registries      | TCP         |
| 80       | HTTP (Docker Registry)      | Alternate port for Docker registries (if configured)            | TCP         |
| 53       | DNS                         | Name resolution for containers in custom Docker networks        | TCP/UDP     |
| Custom   | Container Ports             | Published container ports (e.g., 8080, 5000, etc., vary by app) | TCP/UDP     |

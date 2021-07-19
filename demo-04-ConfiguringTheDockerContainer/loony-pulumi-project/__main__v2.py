"""A Simple Python Web Server"""

import pulumi

from pulumi_docker import Image, DockerBuild, Container, ContainerPortArgs

config = pulumi.Config()

image_name = config.require("image")

version = config.require("version")

port = config.require_int("port")

image = Image(image_name,
              build = DockerBuild(context="app"),
              image_name = f"{image_name}:{version}",
              skip_push = True)


container = Container('simple-web-server-container',
                      image = image.base_image_name,
                      envs = [f"listen_port={port}"],
                      ports = [ContainerPortArgs(internal=port,
                          	            		 external=port)])
pulumi.export("container_id", container.id)

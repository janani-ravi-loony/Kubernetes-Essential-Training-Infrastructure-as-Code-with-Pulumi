"""A Simple Python Web Server"""

import pulumi

from pulumi_docker import Image, DockerBuild

config = pulumi.Config()

image_name = config.require("image")

version = config.require("version")

image = Image(image_name,
              build = DockerBuild(context="app"),
              image_name = f"{image_name}:{version}",
              skip_push = True)



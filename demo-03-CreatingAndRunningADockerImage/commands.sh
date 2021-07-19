
  $ pulumi stack init webserver

  $ pulumi stack select webserver

# Assume that they know how to install Docker on their machine (no need to show Docker install)

  $ docker version

# => See the containers

  $ docker ps

# => Go within the pulmi venv and install pulumi_docker

  $ ls -l


# Install the package that has the Docker resource provider for us to work with Docker

  $ source venv/bin/activate

# => Install pulumi_docker

  $ pip install pulumi_docker

  $ deactivate

# => Inside the project directory, create an application directory:

# => Inside this app directory should be two files. 
# => First, create a main.py (refer "main.py") which will run a very simple Python webserver

  $ mkdir app && cd app

# Show app/main.py in sublimetext

# Show app/Dockerfile in sublimetext

# => Now, lets Build the Docker Image with Pulumi so edit __main__.py (refer "__main__.py")

# => Run pulumi up and it should build your docker image

  $ pulumi config set image "simple-web-server"
  $ pulumi config set version "v1"

  $ pulumi up

# => Run docker images to see the built container

  $ docker images

# => Run docker command to see the message

  $ docker run -p 9000:9000 simple-web-server:v1 

# => Go to localhost:3000, we see the message there

# Welcome to Pulumi!














# Stop the image and the container

# Get the container id from here

  $ docker ps -a

  $ docker rm <container id>

# Get the image id

  $ docker images

  $ docker rmi <image id>



# first lets update the python webapp

# within app/main.py change the code to: (refer main.py)

# => Lets create a docker container which runs the image and pass our configuration to it
# => Define a new resource in the pulumi program the code looks like:(refer __main__v1.py file)

# => Set port and version

  $ pulumi config set port 8000
  $ pulumi config set version 'v2'

# => Run pulumi up

  $ pulumi up

  $ docker ps -a

# => Go to the localhost:8000 and show the message

# => lets export the container-id : (refer __main__v2.py file)

# => Run pulumi up

  $ pulumi up

# => Get the container_id

  $ pulumi stack output container_id

# => We can also use them in scripts

  $ docker stats --no-stream $(pulumi stack output container_id)


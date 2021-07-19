
# https://www.pulumi.com/docs/intro/cloud-providers/kubernetes/setup/

# => Install Kubernetes on mac

  $ brew install kubectl

  $ kubectl version --client

  $ brew install hyperkit 


# HyperKit is an open-source hypervisor for macOS hypervisor, optimized for lightweight virtual machines and container deployment.


# NOTES:
# Minikube is a tool that lets you run Kubernetes locally. minikube runs a single-node Kubernetes cluster on your personal computer (including Windows, macOS and Linux PCs) so that you can try out Kubernetes, or for daily development work.
# This cluster lets you demo Kubernetes operations without requiring the time and resource-consuming installation of full-blown K8s.


  $ brew install minikube

# => Find minikube version

  $ minikube version

# => start minikube

  $ minikube start

# we see it shows:
# 🏄  Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default

# => Show conatiner is created:

  $ docker ps

# Show contexts

  $ kubectl config get-contexts -o name

# => Show more details of nodes:

  $ kubectl get nodes -o wide


# => Show namespaces

  $ kubectl get namespaces


# Show the kubeconfig because this is what Pulumi uses to authenticate against the K8s
# cluster where it is going to deploy our stack

# By default, Pulumi will look for a kubeconfig file in the following locations, just like kubectl:

# The environment variable: $KUBECONFIG,
# Or in current user’s default kubeconfig directory: ~/.kube/config
# If the kubeconfig file is not in either of these locations, Pulumi will not find it, and it will fail to authenticate against the cluster. Set one of these locations to a valid kubeconfig file, if you have not done so already.

  $ nano ~/.kube/config

# => Go to console and lets create loony-kubernetes-python project from there
# => Click on Projects and click on + Create Project
# => Choose Kubernetes and Python
# => Click on "Next" and then "Create Project"
# => Follow the terminal commands within the Pulumi folder on desktop run below code:

  $ mkdir loony-kubernetes-python && cd loony-kubernetes-python

  $ pulumi new kubernetes-python -s clouduser/loony-kubernetes-python/dev

# => Show the files

  $ ls -l 

# => Open files in sublime and show content

# Change the code in __main__.py (refer __main__v1.py)

# IMPORTANT
# Show deployment.yaml (present in the reference_files/ folder) this is the yaml equivalent
## of the deployment that we just created using Pulumi code

## NOTE: Resource names (mention this when we show the code)
# Every resource managed by Pulumi has a logical name that you specify as an argument to its constructor.

# => Show stacks:

  $ pulumi stack ls 

# => Run pulumi up

  $ pulumi up

## NOTE: Auto-naming (mention this when we show the output of the stack creation)
# A resource’s logical and physical names may not match. In fact, most physical resource names in Pulumi are, by default, auto-named.

# => Run kubectel command to see the resources

  $ kubectl get pods

# => We see an NGINX deployment is created
# => Show deployment pod and replicaset (with 1 replica)

  $ kubectl get all


# => Go to console and click on "Resources" and show the "List View" and "Graph View"

# => Now let us change code to configure the replica count
# => Within the __main__.py (refer "__main__v2.py") change the code:

# => Save the code and run below command from terminal to set replica to 4:

  $ pulumi config set replicas 4

  $ pulumi up

# => Now show the numbet of replica

  $ kubectl get all 

# => Now lets see describe the deployment again

  $ kubectl describe deployment

# => Here we can see "Scaled up replica set" and now go to Pulumi.dev.yaml file and there also we see 

# config:
  # kubernetes-python:replicas: "4"

# => Let us do one change to access the NGINX deployment
# => Change the code in __main__.py (refer "__main__v3.py"):

# IMPORTANT
# Show service.yaml (present in the reference_files/ folder) this is the yaml equivalent
## of the service that we just created using Pulumi code

# => Run pulumi up 

  $ pulumi up

# Copy the 'View Live:' give when running pulumi up
# Paste the link in browser
# We see the update is showen there

# => Show the deployment and service:

  $ kubectl get all

# => Here we can see the service name, now lets go port forwarding and access the deployment

  $ kubectl port-forward service/<service-name> 8080:80

# => Go to browser and access http://localhost:8080/
# => Here we can see the nginx deployment
# => Now go to the console and again show the "Resources" in List View and Graph View 



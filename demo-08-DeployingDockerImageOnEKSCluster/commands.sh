
# => Create a new stack for deployment 

  $ pulumi stack init loony-eks-deployment

# => Edit the __main__.py file (refer __main__.py)

# => Create app folder and inside that Dockerfile

  $ mkdir app && cd app

# write code within the Dockerfile (refer Dockerfile)

# Go back to the main project folder

  $ cd ..

  $ source venv/bin/activate

  $ pip install pulumi_docker
  $ pip install pulumi_kubernetes

  $ deactivate

# => Now set region aand run pulumi up 

  $ pulumi config set aws:region us-east-2
  $ pulumi up 

# => Once the deployment is done we will get the app_hostname, base_image_name and image_name

# => Go to aws console and then search for ECR in search and click on it 
# Show the repository
# Click through and show the image


# => Now in terminal copy the app_hostname and paste it in brower and here we can see the html page
# => Now go to the app.pulumi.com and select the project and stack "loony-deployment" and show the resources
# => Now go to terminal and delete the resources

  $ pulumi destroy --yes

# => Now go to aws console and show the image is deleted
# => Once resources are deleted remove the stack 

  $ pulumi stack rm loony-eks-deployment

# => Now select the loony-eks-stack and remove the resources here also

  $ pulumi stack select loony-eks

# => Delete the resources 

  $ pulumi destroy --yes

# => Now go to aws console and show the eks cluster, vpc are deleted
# => Now remove the stack 

  $ pulumi stack rm loony-eks














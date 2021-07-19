
# On the top-right click on Ohio and show that we're working in the us-east-2 region

# => Go to Users 
# => Click on Add User - "loony-pulumi-user" 
# => Give Access type : Programatic access
# => Create a group user - "loony-pulumi-group"
# => Give AmazonS3FullAccess permission
# => Click on "Create Group" -> "Next:Tags" -> "Next Review" -> "Create User"
# => We will get the Access Key and access secret key
# => Lets save these keys within the bash_profile and savethe access keys


# Make sure you are in the pulumi/projects/ folder

  $ nano ~/.bash_profile

  export AWS_ACCESS_KEY_ID=<access key id>
  export AWS_SECRET_ACCESS_KEY=<secret access key>

# => Save the bash_profile and then run

  $ source ~/.bash_profile

# => Show the keys are save successfully

  $ echo $AWS_ACCESS_KEY_ID
  $ echo $AWS_SECRET_ACCESS_KEY

# => Create a new project within the Pulumi folder

  $ mkdir loony-aws-webserver && cd loony-aws-webserver

  $ pulumi new aws-python

# => Press enter for project name, project description and stack name 
# => For region name enter us-east-2 and press enter

# => Show the list of file created

  $ ls -l

# => Open files in sublime and show the content
# Have all files open (no need to show the opening of each file)
# Click on each file one-by-one

# => In __main__.py change the bucket name from "my-bucket" to "loony-pulumi-bucket" (__main__v1.py)

# => run pulumi up

  $ pulumi up

# => In the output we will get the bucket name

# Outputs:
#   + bucket_name: "loony-pulumi-bucket-4f43129"

# => check the output

  $ pulumi stack output

# it shows:
# Current stack outputs (1):
#     OUTPUT       VALUE
#     bucket_name  loony-pulumi-bucket-4f43129

# => Now go to aws console and we see the same bucket name in AWS console
# => Inspect the bucket and for that we will install aws cli 

  $ pip install awscli

# => Configure aws cli 

  $ aws configure

# => Enter access key then secret key and region

  $ aws s3 ls $(pulumi stack output bucket_name)

# => We see the bucket is empty so we will get nothing
# => Lets add an object to the bucket
# => Create a new directory "web" within the loony-pulumi-aws folder
# => create a index.html page

  $ mkdir web && cd web

# => Add all 4 files present in the web/ folder
# Show the files open in sublime (no need to show actually opening up the file)

# => Edit code in __main__.py(refer __main__v2.py)

# => Run pulumi up

  $ pulumi up

# => Select "yes"

# => Go to AWS console and within the bucket we can see all 4 files
# => Use aws command to view content

  $ aws s3 ls $(pulumi stack output bucket_name)

# => We see all 4 files

# => Lets publish this as a website
# => Change the code in __main__.py (refer __main__v3.py)

# => Run pulumi up

  $ pulumi up

# => Copy the link from Outputs and paste it on the browser and we see the website up


# => Now we will make our stack configurable

# => Save the file
# => Change code in __main__.py (refer "__main__v4.py")


# Change the code in index.css to have a different background color for the <body> tag

background-color: #fbb795;



# => Now we can set the directory
# => In the terminal set the directory

  $ pulumi config set web_dir "web"

# => Run pulumi up

  $ pulumi up

# => Copy the link from Outputs and paste it in a browser

# If the background color does NOT change go to three-dot menu on the top-right
# Settings -> Clear Browsing Data -> Hosted App Data (checkbox)
# Clear the cache

# Now refresh the page for your app, and you should get a light orange background


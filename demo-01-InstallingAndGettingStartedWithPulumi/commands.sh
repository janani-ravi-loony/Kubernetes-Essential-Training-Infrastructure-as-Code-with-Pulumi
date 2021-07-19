

# https://www.pulumi.com/docs/get-started/install/

# => Install pulumi using brew

  $ brew install pulumi

# => Check pulumi version

  $ pulumi version

# => type pulumi -h to get the commands

  $ pulumi -h

# => On Desktop we have a folder called Pulumi and we will use this folder for this course:
# => Inside Pulumi create folder as below:

  $ mkdir loony-pulumi-project
  $ cd loony-pulumi-project	

# => Go to pulumi app (https://app.pulumi.com/) 

# => Click on New to Pulumi? Sign up!
# => Click on Email

# => Give username and password info

# => Click on the upper right side icon and show we have login as clouduser
# => Expore the Dashboard, Projects, Policies and Settings tab
# => Now click on "Access Tokens" and "Create token"
# => For description give - "Token for Clouduser"
# => Copy the token and save it at some place. In my case it is as below:

# pul-741805ec88536f8dce514b234cfd54e758245978


# NOTES:
# When you run pulumi login from the command line, you will be prompted for an access token. Once obtained, the access token logs you into the Pulumi Console and lets you interact with the Pulumi service and manage your stacks.


# https://www.pulumi.com/docs/intro/concepts/project/
# => Now go to terminal and type:

  $ pulumi new -y

# => Give the token and press enter
# => Use arrow buttons and choose option "Show additional templates" and press enter
# => Again use arrow and move to python using arrows and press enter
# => Show the files are created:

  $ ls -l 

# => Go to loony-pulumi-project folder and open up __main__.py, Pulumi.yaml file and requirements.txt in Sublime Text
# => Show stack with resources:

  $ pulumi stack ls 

# => Here we can see the Resource count and Last update values are null and in last we have some url
# => Copy the url and basically we will move to the app 
# => Click on Activity, Resources and Settings and show the content 
# => Now go back to the terminal and run below code:

  $ pulumi up

# => Select 'yes' using arrow button and this should run without any error.
# => we see it runs without any error and after that run below command:

  $ pulumi stack ls

# => This time Last Update and Resource Count is now null
# => Go to console and refresh page and we can see the stack is updated
# => Click on Activity, Resources, and Settings and show the update there as well















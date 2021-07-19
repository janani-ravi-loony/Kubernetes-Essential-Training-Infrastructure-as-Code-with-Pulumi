
####################################### demo-02-UnderstandingStacksAndConfiguringPulumi #######################################

# =>  In our project created in the previous demo we will edit the __main__.py (refer __main__v1.py) file
# => Open the folder in Submlime Text (if needed can use PyCharm also)


# NOTES:
# To create a new stack, use pulumi stack init stackName. This creates an empty stack stackName and sets it as the active stack. The project that the stack is associated with is determined by finding the nearest Pulumi.yaml file.

$ pulumi stack ls

$ pulumi stack init test

$ pulumi stack ls

$ pulumi stack select dev

$ pulumi stack ls


#########  Stack outputs
# A stack can export values as stack outputs. These outputs are shown during an update, can be easily retrieved with the Pulumi CLI, and are displayed in the Pulumi Console. They can be used for important values like resource IDs, computed IP addresses, and DNS names.

# => Open __main__.py file (refer __main__v1.py)

# => Save the file and run below commad:

  $ pulumi up

# => Select "yes" and we can see the below output

Outputs:
  + external_ip: "356.23.56.01"

# => lets see which stack we are using

# => We can see the stack is updated.
# => Run pulumi stack ouput to get the outputs



  $ pulumi stack output external_ip

# => We see it prints the external IP


# => Change the code in __main__.py (refer __main__v2.py)

# => Save the code and run pulumi up

  $ pulumi up

# Output

  + bucket_details: {
      + files: 3
      + url  : "s3://loony-dev-bucket"
    }
    external_ip   : "356.23.56.01"


# => Show the output in json format 


  $ pulumi stack output --json


# => Go to Dashboard and we can see the Stack Recently Updated 

# => Click on Projects -> dev and we can see the outputs, its values

# => Lets see now the summary of stack

  $ pulumi stack 

# => Select dev and press enter and we can see the details.

# => Change the code in __main__.py (refer __main__v3.py)

# => Save the code and run pulumi up

  $ pulumi up

# => Select details and it will show the changes we did in code
# => Then select "yes"
# => We can see the output as

Outputs:

  - external_ip   : "356.23.56.01"
  + lb_external_ip: "356.23.56.01"


# => now lets change the key value change the code in __main__.py (refer __main__v3.py)

# => Run pulumi up (select yes)

	$ pulumi up

# => This time the output be as below

Outputs:
  ~ bucket_details: {
        files: 3
      ~ url  : "s3://loony-dev-bucket" => "s3://loony-test-bucket"
    }
  - external_ip   : "356.23.56.01"
  + lb_external_ip: "356.23.56.01"


# Copy the 'View Live:' give when running pulumi up
# Paste the link in browser
# We see the update is shown there


######## Configuration system for each project
# https://www.pulumi.com/docs/intro/concepts/config/

# Let's change to the second stack that we had created earlier

  $ pulumi stack select test

# => To understand and managing configuration in pulumi, lets add some configuration
# => Edit code for __main__.py file (refer "__main__v4.py")

# => Run pulumi up and it will throw error

  $ pulumi up


#      Type                 Name                       Plan       Info
#  +   pulumi:pulumi:Stack  loony-pulumi-project-test  create     2 errors
 
# Diagnostics:
#   pulumi:pulumi:Stack (loony-pulumi-project-test):
#     error: Missing required configuration variable 'loony-pulumi-project:num_nodes'
#         please set a value using the command `pulumi config set loony-pulumi-project:num_nodes <value>`
#     error: an unhandled error occurred: Program exited with non-zero exit code: 1
 

# => Lets set this configuration and re-run pulumi up

  $ pulumi config set num_nodes 4

  $ pulumi up

# => Go to Pulumi.test.yaml file where we can see the config value

# config:
#   loony-pulumi-project:num_nodes: "4"


# => Go to the console, click on the "test" stack
# => There we can see within the Configuration, the name and value


# => Similarly we have optional value

# => within the main.py change the code (refer __main__v5.py)

# => Run pulumi up and we should see the optional value for the config setting exported

$ pulumi up


Outputs:
    cluster_details: {
        external_ip: "324.23.45.98"
        num_nodes  : "4"
    }
  + region         : "us-west-2"


# => Lets set the optional value time

	$ pulumi config set region "asia-south-1"

# => Rerun pulumi up

  $ pulumi up

# => We see the value is now added open "Pulumi.loony-stack.yaml" and we can see the values here

config:
  loony-pulumi-project:num_nodes: "4"
  loony-pulumi-project:region: asia-south-1


~ region         : "us-west-2" => "asia-south-1"


############## Configuring secrets
# https://www.pulumi.com/docs/intro/concepts/secrets/

# => We can set secret value using the --secret flag

# => within the main.py change the code (refer __main__v6.py)

# => We can set the secret value using --secret

  $ pulumi config set db_password "password123" --secret

# => Run pulumi up

  $ pulumi up

# => Now we see that the secret output is not in plaintext in the terminal

# => In the Pulumi program directory, Go to Pulumi.loony-test.yaml file where we can see the config value

# config:
#   loony-pulumi-project:db_password:
#     secure: AAABAC2wycjnUlON/QJ+Uro5NMO6gO1R6jsXXWyDaS9m/gmdFX9HV/iXFg==
#   loony-pulumi-project:num_nodes: "4"
#   loony-pulumi-project:region: asia-south-1


  $ pulumi stack select dev

# => run pulumi up

  $ pulumi up

# => we see it throws error	
# => Our new stack does not have the configuration values. Configuration is stack dependent. 
# => Now export and stack in json format and delete the stack 

  $ pulumi stack export --file dev_stack.json

# => Show the json file and its content 

  $ ls -l 

  $ nano dev_stack.json

# => We would be be using test, so lets delete the dev:

  $ pulumi destroy --yes

  $ pulumi stack rm dev

# => Enter "dev"
# => And our "dev" stack will be deleted

  $ pulumi stack ls

# => Go to console and select the project and we can see here also "dev" stack is deleted


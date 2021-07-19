
####################### demo-08-CreatingEKSClusterOnAWS ####################### 


# => Lets go to aws console IAM -> UserGroup
# => Click on user group name "loony-pulumi-group" and then click on "Permissions"
# => Now click on "Permissions" -> "Add permissions"
# => Click on "Attach Policies" and in filter search for below policies and add then one by one 

# AmazonEC2FullAccess
# IAMFullAccess
# AmazonEC2ContainerRegistryFullAccess
# AWSCloudFormationFullAccess


# => Once the policies are added now add eks policies using json file 
# => Click on "Add permissions" -> "Create Inline Policy"
# => Click on json and add below content:

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "eks:*"
            ],
            "Resource": "*"
        }
    ]
}

# => Give the policy a name "eks_all_access_policy"
# => Click on "Review Policy" and click on "Next" and "Create Policy"

# IMPORTANT Show the final list of all permissions in the Permissions tab


# => Once the policies are added now go to terminal and add below python file for EKS Service Roles, EKS NodeGroupRoles, VPC, Security group and Cluster NodeGroup

# => Now create a stack for creating cluster 

  $ pulumi stack init loony-eks


# NOTES:
# When you create a cluster resource in Amazon EKS, you must choose a role to allow Amazon EKS to access several other AWS resources on your behalf.

# Kubernetes clusters managed by Amazon EKS make calls to other AWS services on your behalf to manage the resources that you use with the service. Before you can create Amazon EKS clusters, you must create an IAM role with the following IAM policies:
# AmazonEKSClusterPolicy

# Prior to April 16, 2020, AmazonEKSServicePolicy was also required With the AWSServiceRoleForAmazonEKS service-linked role, that policy is no longer required for clusters created on or after April 16, 2020.
# Amazon EKS uses the service-linked role named AWSServiceRoleForAmazonEKS – The role allows Amazon EKS to manage clusters in your account. 
# You don't need to manually create a service-linked role. When you create a cluster in the AWS Management Console, the AWS CLI, or the AWS API, Amazon EKS creates the service-linked role for you.

# The Amazon EKS node kubelet daemon makes calls to AWS APIs on your behalf. Nodes receive permissions for these API calls through an IAM instance profile and associated policies. Before you can launch nodes and register them into a cluster, you must create an IAM role for those nodes to use when they are launched. 

# The Amazon VPC CNI plugin for Kubernetes is the networking plugin for pod networking in Amazon EKS clusters. The plugin is responsible for allocating VPC IP addresses to Kubernetes nodes and configuring the necessary networking for pods on each node. 

# => create iam.py (refer iam.py)


# => Save the file and create vpc.py (refer vpc.py)

# => Save the file and create utils.py (refer utils.py)



# => Now edit the __main__.py 

# => Run pulumi up and the cluster will be created

  $ pulumi config set aws:region us-east-2
  $ pulumi up 

# While the cluster is updating click on the link next to "View Live" 
# Go to the "Resources" tab and show the graph view
# => Show in list view and graph list 

# => Once the cluster is created goto aws console and search for "Kubernetes" click on the link and go to "clusters"

# => Here we can see the cluster is created

# => Click through and show that we cannot view the nodes for this cluster
# https://docs.aws.amazon.com/eks/latest/userguide/troubleshooting_iam.html#security-iam-troubleshoot-cannot-view-nodes-or-workloads

# => Using the search box search for "EC2"
# => Click on instances and show that the nodes are visible here

# => Now go to VPC from search box and show the vpc, subnet, security group

# => Now go to IAM and in search box type eks-iam-role show the roles are created

# => View the stack output

  $ pulumi stack output

# => Update the kubeconfig

  $ aws eks --region us-east-2 update-kubeconfig --name $(pulumi stack output cluster-name)

# => See the nodes

  $ kubectl get nodes

# NAME                                         STATUS   ROLES    AGE     VERSION
# ip-10-100-0-127.us-east-2.compute.internal   Ready    <none>   8m15s   v1.19.6-eks-49a6c0
# ip-10-100-1-200.us-east-2.compute.internal   Ready    <none>   8m7s    v1.19.6-eks-49a6c0
# ip-10-100-2-219.us-east-2.compute.internal   Ready    <none>   8m8s    v1.19.6-eks-49a6c0


# Check out the connectivity

  $ kubectl cluster-info

# it shows:

# Kubernetes control plane is running at https://B504E227F478D448CD457C0D50F3CCAC.gr7.us-east-2.eks.amazonaws.com
# CoreDNS is running at https://B504E227F478D448CD457C0D50F3CCAC.gr7.us-east-2.eks.amazonaws.com/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

# => Get the pods too

  $ kubectl get pods -A -o wide

# => Now in next demo we will deploy the docker image from ecr on kubernetes cluster 



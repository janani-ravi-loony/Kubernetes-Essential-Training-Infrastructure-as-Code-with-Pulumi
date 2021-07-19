"""A Python Pulumi program"""

import pulumi

config = pulumi.Config()

num_nodes = config.require('num_nodes')
region = config.get('region')

print("Number of nodes in cluster: ", num_nodes)
print("Region: ", region)


pulumi.export("cluster_details", {
	"external_ip" : "324.23.45.98",
	"num_nodes" : num_nodes
})

if (region):
	pulumi.export("region", region)
else:
	pulumi.export("region", "us-west-2")

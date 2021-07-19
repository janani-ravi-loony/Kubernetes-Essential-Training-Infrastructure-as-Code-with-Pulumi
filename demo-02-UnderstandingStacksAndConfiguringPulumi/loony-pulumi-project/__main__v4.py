"""A Python Pulumi program"""

import pulumi

config = pulumi.Config()

num_nodes = config.require('num_nodes')

print("Number of nodes in cluster: ", num_nodes)

pulumi.export("cluster_details", {
	"external_ip" : "324.23.45.98",
	"num_nodes" : num_nodes
})

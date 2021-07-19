"""A Python Pulumi program"""

import pulumi

pulumi.export("lb_external_ip", "356.23.56.01")

pulumi.export("bucket_details", {
	"url" : "s3://loony-test-bucket",
	"files" : 3
})


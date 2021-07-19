"""A Python Pulumi program"""

import pulumi

pulumi.export("external_ip", "356.23.56.01")

pulumi.export("bucket_details", {
	"url" : "s3://loony-dev-bucket",
	"files" : 3
})

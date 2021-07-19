"""An AWS Python Pulumi program"""

import pulumi
from pulumi_aws import s3

import mimetypes
import os

bucket = s3.Bucket("loony-pulumi-bucket", website={"index_document": "index.html"})

config = pulumi.Config()
web_dir = config.require("web_dir")


for file in os.listdir(web_dir):

    filepath = os.path.join(web_dir, file)
    mime_type, _ = mimetypes.guess_type(filepath)

    obj = s3.BucketObject(file,
		bucket=bucket.id,
		source=pulumi.FileAsset(filepath),
		acl="public-read",
		content_type=mime_type)

pulumi.export("bucket_name", bucket.id)
pulumi.export('bucket_endpoint', pulumi.Output.concat("http://", bucket.website_endpoint))
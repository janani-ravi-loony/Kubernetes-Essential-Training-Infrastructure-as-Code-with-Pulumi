"""An AWS Python Pulumi program"""

import pulumi
from pulumi_aws import s3

import mimetypes
import os

# Create an AWS resource (S3 Bucket)
bucket = s3.Bucket("loony-pulumi-bucket", website={"index_document": "index.html"})

html_filepath = os.path.join("web", "index.html")
html_mime_type, _ = mimetypes.guess_type(html_filepath)

css_filepath = os.path.join("web", "index.css")
css_mime_type, _ = mimetypes.guess_type(css_filepath)

fish_bones_filepath = os.path.join("web", "fish-bones.png")
fish_bones_mime_type, _ = mimetypes.guess_type(fish_bones_filepath)

fish_filepath = os.path.join("web", "fish.png")
fish_mime_type, _ = mimetypes.guess_type(fish_filepath)


html_obj = s3.BucketObject(
	"index.html", bucket=bucket.id, source=pulumi.FileAsset(html_filepath), 
	acl="public-read", content_type=html_mime_type)

css_obj = s3.BucketObject(
	"index.css", bucket=bucket.id, source=pulumi.FileAsset(css_filepath), 
	acl="public-read", content_type=css_mime_type)

fish_bones_obj = s3.BucketObject(
	"fish-bones.png", bucket=bucket.id, source=pulumi.FileAsset(fish_bones_filepath), 
	acl="public-read", content_type=fish_bones_mime_type)

fish_obj = s3.BucketObject(
	"fish.png", bucket=bucket.id, source=pulumi.FileAsset(fish_filepath), 
	acl="public-read", content_type=fish_mime_type)

# Export the name of the bucket and the endpoint
pulumi.export("bucket_name", bucket.id)
pulumi.export('bucket_endpoint', pulumi.Output.concat("http://", bucket.website_endpoint))

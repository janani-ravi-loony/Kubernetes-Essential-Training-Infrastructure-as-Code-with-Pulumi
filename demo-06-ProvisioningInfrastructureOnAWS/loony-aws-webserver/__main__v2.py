"""An AWS Python Pulumi program"""

import pulumi
from pulumi_aws import s3

import os

# Create an AWS resource (S3 Bucket)
bucket = s3.Bucket("loony-pulumi-bucket")

html_filepath = os.path.join("web", "index.html")
css_filepath = os.path.join("web", "index.css")
fish_bones_filepath = os.path.join("web", "fish-bones.png")
fish_filepath = os.path.join("web", "fish.png")

html_obj = s3.BucketObject(
	"index.html", bucket=bucket.id, source=pulumi.FileAsset(html_filepath))

css_obj = s3.BucketObject(
	"index.css", bucket=bucket.id, source=pulumi.FileAsset(css_filepath))

fish_bones_obj = s3.BucketObject(
	"fish-bones.png", bucket=bucket.id, source=pulumi.FileAsset(fish_bones_filepath))

fish_obj = s3.BucketObject(
	"fish.png", bucket=bucket.id, source=pulumi.FileAsset(fish_filepath))

# Export the name of the bucket
pulumi.export("bucket_name", bucket.id)

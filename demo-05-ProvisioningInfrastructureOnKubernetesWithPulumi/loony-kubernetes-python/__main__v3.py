"""A Kubernetes Python Pulumi program"""

import pulumi
from pulumi_kubernetes.apps.v1 import Deployment, DeploymentSpecArgs
from pulumi_kubernetes.meta.v1 import LabelSelectorArgs, ObjectMetaArgs
from pulumi_kubernetes.core.v1 import ContainerArgs, PodSpecArgs, PodTemplateSpecArgs
from pulumi_kubernetes.core.v1 import Service

config = pulumi.Config()

app_labels = { "app": "nginx" }

deployment = Deployment(
    "nginx-deployment",

    spec=DeploymentSpecArgs(
        selector=LabelSelectorArgs(match_labels=app_labels),

        replicas=1 if config.get_int("replicas") is None else config.get_int("replicas"),

        template=PodTemplateSpecArgs(
            metadata=ObjectMetaArgs(labels=app_labels),
            spec=PodSpecArgs(containers=[ContainerArgs(name="nginx", image="nginx")])
        ),
    ))


frontend = Service(
    "nginx-service",
    
    metadata={"labels": deployment.spec["template"]["metadata"]["labels"]},
    spec={"type": "ClusterIP",
          "ports": [{ "port": 80, "target_port": 80, "protocol": "TCP" }],
          "selector": app_labels}
    )

result = frontend.spec.apply(lambda v: v["cluster_ip"] if "cluster_ip" in v else None)

pulumi.export("ip", result)

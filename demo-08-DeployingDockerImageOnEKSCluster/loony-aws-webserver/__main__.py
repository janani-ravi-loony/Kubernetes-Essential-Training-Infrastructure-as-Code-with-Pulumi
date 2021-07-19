import base64
import pulumi

import pulumi_aws as aws
import pulumi_docker as docker
import pulumi_kubernetes as k8s

repo = aws.ecr.Repository('loony-repo')

def getRegistryInfo(rid):

    creds = aws.ecr.get_credentials(registry_id=rid)
    decoded = base64.b64decode(creds.authorization_token).decode()
    parts = decoded.split(':')

    if len(parts) != 2:
        raise Exception("Invalid credentials")
    return docker.ImageRegistry(creds.proxy_endpoint, parts[0], parts[1])

image_name = repo.repository_url

registry_info = repo.registry_id.apply(getRegistryInfo)

image = docker.Image('loony-image',
    build='app',
    image_name=image_name,
    registry=registry_info,
)

app_labels = { 'app': 'loony-app' }

app_dep = k8s.apps.v1.Deployment('loony-app-dep',
    spec={
        'selector': { 'matchLabels': app_labels },
        'replicas': 3,
        'template': {
            'metadata': { 'labels': app_labels },
            'spec': {
                'containers': [{
                    'name': 'loony-app',
                    'image': image.image_name,
                }],
            },
        },
    },
)

app_svc = k8s.core.v1.Service('loony-app-svc',
    metadata={ 'labels': app_labels },
    spec={
        'type': 'LoadBalancer',
        'ports': [{ 'port': 80, 'targetPort': 80, 'protocol': 'TCP' }],
        'selector': app_labels,
    }
)

pulumi.export('app_hostname', app_svc.status.apply(lambda s: s.load_balancer.ingress[0].hostname))
pulumi.export('base_image_name', image.base_image_name)
pulumi.export('image_name', image.image_name)



# version_settings() enforces a minimum Tilt version
# https://docs.tilt.dev/api.html#api.version_settings
version_settings(constraint='>=0.22.2')

include('./src/gateway-server/Tiltfile')

include('./src/identity-authorization-server/Tiltfile')

include('./src/user-management-service/Tiltfile')

docker_build(
    'artemis-server',
    context='src/artemis-server'
)

include('./src/websocket-server/Tiltfile')

include('./src/web-frontend/Tiltfile')

yaml = kustomize('./k8s/overlays/local')
k8s_yaml(yaml)

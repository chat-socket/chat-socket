# version_settings() enforces a minimum Tilt version
# https://docs.tilt.dev/api.html#api.version_settings
version_settings(constraint='>=0.22.2')

# include('./src/gateway-server/Tiltfile')

# include('./src/identity-authorization-server/Tiltfile')

# include('./src/user-management-service/Tiltfile')

# include('./src/websocket-server/Tiltfile')

# include('./src/web-frontend/Tiltfile')

yaml = kustomize('./k8s/overlays/dev')
k8s_yaml(yaml)

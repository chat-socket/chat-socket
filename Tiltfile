# version_settings() enforces a minimum Tilt version
# https://docs.tilt.dev/api.html#api.version_settings
version_settings(constraint='>=0.22.2')

# tilt-avatar-api is the backend (Python/Flask app)
# live_update syncs changed source code files to the correct place for the Flask dev server
# and runs pip (python package manager) to update dependencies when changed
# https://docs.tilt.dev/api.html#api.docker_build
# https://docs.tilt.dev/live_update_reference.html

local_resource(
  'gateway-server-compile',
  'cd src/gateway-server; /bin/bash gradlew clean installDist',
  deps=['src/gateway-server/src', 'src/gateway-server/build.gradle'])

docker_build(
    'gateway-server',
    context='src/gateway-server/build/install',
    dockerfile="./docker/Dockerfile.generic"
)


local_resource(
  'identity-authorization-server-compile',
  'cd src/identity-authorization-server; /bin/bash gradlew clean installDist',
  deps=['src/identity-authorization-server/src', 'src/identity-authorization-server/build.gradle'])

docker_build(
    'identity-authorization-server',
    context='src/identity-authorization-server/build/install',
    dockerfile="./docker/Dockerfile.generic"
)


local_resource(
  'user-management-service-compile',
  'cd src/user-management-service; /bin/bash gradlew clean installDist',
  deps=['src/user-management-service/src', 'src/user-management-service/build.gradle'])

docker_build(
    'user-management-service',
    context='src/user-management-service/build/install',
    dockerfile="./docker/Dockerfile.generic"
)

docker_build(
    'artemis-server',
    context='src/artemis-server'
)

local_resource(
  'websocket-server-compile',
  'cd src/websocket-server; /bin/bash gradlew clean installDist',
  deps=['src/websocket-server/src', 'src/websocket-server/build.gradle'])

docker_build(
    'websocket-server',
    context='src/websocket-server/build/install',
    dockerfile="./docker/Dockerfile.generic"
)


docker_build(
    'web-frontend', 
    context='src/web-frontend',
    dockerfile="src/web-frontend/Dockerfile.tilt",
    live_update=[
        # when package.json changes, we need to do a full build
        sync('src/web-frontend/src', '/usr/src/app/src'),
    ]
)


yaml = kustomize('./k8s/overlays/local')
k8s_yaml(yaml)

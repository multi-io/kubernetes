# Development in our Kubermatic Fork

SysEleven Kubernetes fork for getting custom patches out to customers more quickly.

## Building Using the CI

- check out / create the commit you want to build
  - convention is that our patch branches should be named v1.x.y-sys11-patches, e.g. `v1.15.3-sys11-patches`
  - so in that case, you'd `git checkout v1.15.3-sys11-patches`
- git tag v1.x.y-sys11-n  # e.g. v1.15.3-sys11-1
- git push origin   # where origin = git@github.com:syseleven/kubernetes.git
- CI (Travis) will build and push image `syseleven/hyperkube-amd64:v1.x.y-sys11-n`

## Building Locally

- on macOS, increase the Docker engine's memory limit to at least 5G
- check out / create the commit you want to build. See above.
- git tag v1.x.y-sys11-n  # e.g. v1.15.3-sys11-1
- make -f sys11.make
- docker push syseleven/hyperkube-amd64:v1.x.y-sys11-n

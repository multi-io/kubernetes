REGISTRY=syseleven
VERSION=$(shell hack/print-workspace-status.sh | grep gitVersion | awk '{print $$2}')

default: compile-image tag-image

compile-image:
	$(MAKE) quick-release-images KUBE_BUILD_CONFORMANCE=n

tag-image:
	$(MAKE) -C cluster/images/hyperkube REGISTRY=$(REGISTRY) VERSION=$(VERSION) build

ci-push-image:
	echo "$$DOCKER_PASSWORD" | docker login -u "$$DOCKER_USERNAME" --password-stdin
	docker push "$(REGISTRY)/hyperkube-amd64:$(VERSION)"

REGISTRY=syseleven
VERSION=$(shell hack/print-workspace-status.sh | grep gitVersion | awk '{print $$2}')

default: compile

compile:
	# build kubelet kubectl first. Workaround for https://github.com/kubernetes/kubernetes/issues/86233
	build/run.sh make kubelet kubectl
	$(MAKE) quick-release-images KUBE_BUILD_CONFORMANCE=n REGISTRY=$(REGISTRY) VERSION=$(VERSION)

ci-push-image:
	echo "$$DOCKER_PASSWORD" | docker login -u "$$DOCKER_USERNAME" --password-stdin
	docker push "$(REGISTRY)/hyperkube-amd64:$(VERSION)"

ci-upload-kubelet-binary:
	docker run -e AWS_ACCESS_KEY_ID=$$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$$AWS_SECRET_ACCESS_KEY -v $(PWD)/_output/dockerized/bin/linux/amd64:/binaries schickling/s3cmd --host=s3.dbl.cloud.syseleven.net --host-bucket='%(bucket).s3.dbl.cloud.syseleven.net' put -P /binaries/kubelet s3://sys11-metakube-kubelet/$(VERSION)/

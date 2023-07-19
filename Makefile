IMAGE_NAME=resmio/docker-python


build:
	docker build . -t ${IMAGE_NAME} --force-rm

tag-10:
	docker push ${IMAGE_NAME}:10

push-tag-latest:
	docker push ${IMAGE_NAME}

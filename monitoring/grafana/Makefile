.PHONY: init deploy run build

build:
	docker buildx build --no-cache --push --platform linux/arm/v7,linux/arm/v8,linux/amd64 -t ${TF_VAR_grafana_image} .


run: build



.PHONY: init deploy run build

CONFIGS_ENV := $(PWD)/../tf_configs.env
include $(CONFIGS_ENV)

export

CURRENT_TIME := `date +%s`

build:
	docker buildx build --no-cache --push --platform linux/arm/v7,linux/arm/v8,linux/amd64 -t ${TF_VAR_grafana_image}:latest .

run: build



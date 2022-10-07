.PHONY: grafana

BACKEND_ENV := $(PWD)/tf_backend.env
include $(BACKEND_ENV)

CONFIGS_ENV := $(PWD)/tf_configs.env
include $(CONFIGS_ENV)

export

setup:
	$(call setup_env,tf_backend)

load_tf_vars:
	$(call setup_env,tf_configs)

grafana:
	cd ./grafana && $(MAKE) run

.PHONY: grafana

define setup_env
	$(eval ENV_FILE := $(1).env)
	@echo " - setup env $(ENV_FILE)"
	$(eval include $(1).env)
	$(eval export sed 's/=.*//' $(1).env)
endef

setup:
	$(call setup_env,tf_backend)

load_tf_vars:
	$(call setup_env,tf_configs)


grafana: setup load_tf_vars
	cd ./grafana && \
		profile=${profile} bucket=${bucket} region=${region} key=${key} role_arn=${role_arn} \
		nfs_server=${nfs_server} nfs_path=${nfs_path} storage=${storage} grafana_image=${grafana_image} \
	$(MAKE) run

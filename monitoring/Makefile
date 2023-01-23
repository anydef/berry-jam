.PHONY: grafana

BACKEND_ENV := $(PWD)/tf_backend.env
include $(BACKEND_ENV)

CONFIGS_ENV := $(PWD)/tf_configs.env
include $(CONFIGS_ENV)

export

tf_init:
	terraform -chdir=$(FOLDER) init \
	-backend-config "bucket=${bucket}" \
	-backend-config "profile=${profile}" \
	-backend-config "region=${region}" \
	-backend-config "key=$(FOLDER).tfstate" \
	-backend-config "role_arn=${role_arn}"

tf_refresh:
	terraform -chdir=$(FOLDER) refresh

tf_apply:
	terraform -chdir=$(FOLDER) apply -auto-approve -lock=false

tf_destroy:
	terraform -chdir=$(FOLDER) destroy -auto-approve -lock=false

make_run:
	cd $(FOLDER) && $(MAKE) run

persistence: FOLDER=persistence
persistence: tf_init tf_refresh tf_apply

grafana: FOLDER=grafana
grafana: tf_init tf_refresh tf_apply
#grafana: tf_init make_run tf_apply

grafana-destroy: FOLDER=grafana
grafana-destroy: tf_init tf_refresh tf_destroy

namespace: FOLDER=namespace
namespace: tf_init tf_refresh tf_apply

prometheus-operator: FOLDER=prometheus-operator
prometheus-operator: tf_init tf_apply

prometheus: FOLDER=prometheus
prometheus: tf_init tf_apply

prometheus-destroy: FOLDER=prometheus
prometheus-destroy: tf_init tf_destroy

pushgateway: FOLDER=pushgateway
pushgateway: tf_init tf_apply

state-metrics: FOLDER=state-metrics
state-metrics: tf_init tf_apply

node-exporter: FOLDER=node-exporter
node-exporter: tf_init tf_apply

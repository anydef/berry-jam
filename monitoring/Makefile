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
	terraform -chdir=$(FOLDER) get -update
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
prometheus-operator: tf_init tf_refresh tf_apply

prometheus-operator-destroy: FOLDER=prometheus-operator
prometheus-operator-destroy: tf_init tf_refresh tf_destroy


prometheus-home-automation: FOLDER=prometheus-home-automation
prometheus-home-automation: tf_init tf_refresh tf_apply

prometheus-home-automation-destroy: FOLDER=prometheus-home-automation
prometheus-home-automation-destroy: tf_init tf_destroy

prometheus-cluster-monitoring: FOLDER=prometheus-cluster-monitoring
prometheus-cluster-monitoring: tf_init tf_refresh tf_apply

prometheus-cluster-monitoring-destroy: FOLDER=prometheus-cluster-monitoring
prometheus-cluster-monitoring-destroy: tf_init tf_refresh tf_destroy


pushgateway: FOLDER=pushgateway
pushgateway: tf_init tf_refresh tf_apply

pushgateway-destroy: FOLDER=pushgateway
pushgateway-destroy: tf_init tf_destroy


state-metrics: FOLDER=state-metrics
state-metrics: tf_init tf_refresh tf_apply

state-metrics-destroy: FOLDER=state-metrics
state-metrics-destroy: tf_init tf_refresh tf_destroy


node-exporter: FOLDER=node-exporter
node-exporter: tf_init tf_refresh tf_apply

node-exporter-destroy: FOLDER=node-exporter
node-exporter-destroy: tf_init tf_refresh tf_destroy

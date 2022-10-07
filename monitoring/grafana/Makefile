.PHONY: init deploy run build

init:
	terraform init \
    -backend-config "bucket=${bucket}" \
    -backend-config "profile=${profile}" \
    -backend-config "region=${region}" \
    -backend-config "key=${key}" \
    -backend-config "role_arn=${role_arn}"


build:
	docker buildx build --no-cache --push --platform linux/arm/v7,linux/arm/v8,linux/amd64 -t ${TF_VAR_grafana_image} .

	#TF_VAR_nfs_server=${nfs_server} TF_VAR_nfs_path=${nfs_path} TF_VAR_storage=${storage} TF_VAR_image=${grafana_image} \
deploy: init
	terraform apply -auto-approve -lock=false

run: build deploy



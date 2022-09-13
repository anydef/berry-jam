build:
	docker buildx build --no-cache --push --platform linux/arm/v7,linux/arm/v8,linux/amd64 -t anydef/grafana:latest .

init:
	terraform -chdir=terraform init
plan:
	terraform -chdir=terraform plan
deploy: init
	terraform -chdir=terraform apply -auto-approve -lock=false

delete: init
	terraform -chdir=terraform destroy -auto-approve -lock=false


build:
	docker buildx build --no-cache --push --platform linux/arm/v7,linux/arm/v8,linux/amd64 -t anydef/nginx_sample_app:latest .

restart_deployment:
	kubectl --kubeconfig ~/.kube/config-berry-k3s rollout restart deployment/sample-nginx-app-deployment

apply:
	kubectl --kubeconfig ~/.kube/config-berry-k3s apply -f hello-world.yaml

deploy: build apply
	$(MAKE) restart_deployment
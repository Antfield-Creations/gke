BINDIR ?= ~/.local/bin
GCLOUDDIR ?= ~/.local/google-cloud-sdk

tools: kubectl helm

gcloud-sdk:
	which gcloud || curl https://sdk.cloud.google.com > /tmp/install.sh && \
		bash install.sh --install-dir=${GCLOUDDIR} && \
		rm /tmp/install.sh

kubectl:
	# kubectl needs to be installed using the gcloud cli in order to enable the gke-gcloud-auth-plugin
	gcloud components install kubectl
	kubectl version --client

helm:
	# Install helm
	curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 > /tmp/install.sh && \
		HELM_INSTALL_DIR=${BINDIR} bash /tmp/install.sh --no-sudo
	helm version

cd:
	helm dependency update charts/antfield-argocd
	helm --namespace=operators install antfield-argocd charts/antfield-argocd

cd-update:
	helm dependency update charts/antfield-argocd
	helm --namespace=operators upgrade antfield-argocd charts/antfield-argocd

cd-tunnel:
	kubectl -n operators port-forward svc/antfield-argocd-server 8082:80

wf-tunnel:
	kubectl -n operators port-forward svc/argo-workflows-server 2746:2746

pg-tunnel:
	kubectl -n operators port-forward svc/operators-postgresql 5432:5432

gcs-secrets:
	- kubectl -n operators create secret generic gcs-secret \
		--from-file=serviceAccountKey=/home/rein/Nextcloud/Documents/fafa-vae-0102b4da1611.json
	- kubectl -n data create secret generic gcs-secret \
		--from-file=serviceAccountKey=/home/rein/Nextcloud/Documents/fafa-vae-0102b4da1611.json

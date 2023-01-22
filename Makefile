BINDIR ?= ~/.local/bin

tools: kubectl helm

kubectl:
	# Install kubectl
	which kubectl || curl -fSL "https://dl.k8s.io/release/$(shell curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o ${BINDIR}/kubectl
	which kubectl || chmod +x ${BINDIR}/kubectl
	kubectl version --client

helm:
	# Install helm
	USE_SUDO=false HELM_INSTALL_DIR=${BINDIR} curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
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

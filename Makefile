cd:
	helm dependency update charts/antfield-argocd
	helm --namespace=operators install antfield-argocd charts/antfield-argocd

cd-tunnel:
	kubectl -n operators port-forward svc/antfield-argocd-server 8082:80

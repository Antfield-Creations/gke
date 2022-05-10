cd:
	helm dependency update charts/antfield-argocd
	helm --namespace=operators install antfield-argocd charts/antfield-argocd

cd-update:
	helm dependency update charts/antfield-argocd
	helm --namespace=operators upgrade antfield-argocd charts/antfield-argocd

cd-tunnel:
	kubectl -n operators port-forward svc/antfield-argocd-server 8082:80

pg-tunnel:
	kubectl -n operators port-forward svc/operators-postgresql 5432:5432

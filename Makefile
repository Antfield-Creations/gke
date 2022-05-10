cd:
	helm dependency update charts/antfield-argocd
	helm --namespace=operators install antfield-argocd charts/antfield-argocd

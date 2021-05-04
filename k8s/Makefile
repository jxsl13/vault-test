

deploy: 
	./make.sh

connect:
	kubectl exec -it --namespace vault vault-0 -- /bin/sh

delete:
	helm uninstall consul --namespace vault
	helm uninstall vault --namespace vault
	kubectl delete namespace vault

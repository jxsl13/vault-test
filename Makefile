


deploy:
	docker-compose up --force-recreate
	docker-compose down

build:
	docker-compose build --force-rm --no-cache

rebuild:
	docker-compose build --force-rm

connect:
	docker exec -it ansible-vault-configuration /bin/bash

port-forward:
	xterm -hold -e 'kubectl port-forward --namespace vault vault-0 8200:8200' &

delete:
	kubectl delete namespace vault

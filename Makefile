


deploy:
	docker-compose --env-file .env up --force-recreate
	docker-compose down

build:
	docker-compose build --force-rm --no-cache

rebuild:
	docker-compose build --force-rm

# there is a rare case where your sshd config does disable PubKey authentication whysoever
# at random...
ping:
	ansible -m ping localhost -k

connect:
	docker exec -it ansible-vault-configuration /bin/bash

port-forward:
	xterm -hold -e 'kubectl port-forward --namespace vault vault-0 8200:8200' &


delete:
	kubectl delete namespace vault

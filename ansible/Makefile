


deploy:
	ansible-playbook -i hosts vault-playbook.yaml

requirements:
	# install pip
	curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
	python3 get-pip.py
	rm get-pip.py
	
	# install python modules/packages
	python3 -m pip install openshift kubernetes pyyaml
	
	# install helm plugin
	helm plugin install https://github.com/databus23/helm-diff
	
	# install kubernetes plugin
	ansible-galaxy collection install kubernetes.core
	

delete:
	kubectl delete namespace vault

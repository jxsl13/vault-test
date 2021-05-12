


deploy:
	ansible-playbook -i hosts.txt vault-playbook.yaml

# there is a rare case where your sshd config does disable PubKey authentication whysoever
# at random...
ping:
	ansible -m ping localhost -k

connect:
	kubectl exec -it --namespace vault vault-0 -- /bin/sh

port-forward:
	cd .. && ./k8s/scripts/./portforward.sh

requirements:
	# install pip
	curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
	python3 get-pip.py
	rm get-pip.py
	
	# install python modules/packages
	python3 -m pip install openshift kubernetes pyyaml requests hvac
	
	# install helm plugin
	-helm plugin install https://github.com/databus23/helm-diff
	
	# install kubernetes plugin
	ansible-galaxy collection install kubernetes.core
	ansible-galaxy install 'git+https://github.com/TerryHowe/ansible-modules-hashivault.git'
	@echo "========= ADD THESE ENVIRONMENT VARIABLES TO YOUR .bashrc =========="
	export ANSIBLE_LIBRARY="${HOME}/.local/lib/python3.8/site-packages/ansible/modules"
	export ANSIBLE_MODULE_UTILS="${HOME}/.local/lib/python3.8/site-packages/ansible/module_utils"

delete:
	kubectl delete namespace vault

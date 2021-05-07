# ansible playbook in order to provision HashiCorp Vault in a Kubernetes Environment


## Requirements

- *kubectl* must be installe sin your control node (where ansible runs)
- [Install ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible-on-ubuntu)


Install the Kubernetes module for ansible
```
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py
rm get-pip.py
python3 -m pip install openshift kubernetes pyyaml


ansible-galaxy collection install kubernetes.core
```

Helm plugin for improved state checking of helm charts.
```
helm plugin install https://github.com/databus23/helm-diff
```
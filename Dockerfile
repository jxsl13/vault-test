FROM python:3.9-slim-buster

ARG VAULT_VERSION=1.7.2
ARG HOME=/root

# update repos and install base deps packages
RUN apt update && \
    apt install software-properties-common gpg gnupg python3-distutils curl git -y

# install pip
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3 get-pip.py && \
    rm get-pip.py

# install python packages, especially Ansible!
RUN python3 -m pip install ansible openshift kubernetes pyyaml requests hvac ansible-modules-hashivault

# install kubectl & helm
RUN curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl \
    && curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
    && chmod +x get_helm.sh && ./get_helm.sh && rm get_helm.sh

# install vault (shadow-utils removed)
RUN set -eux; \
    apt install -y ca-certificates gnupg openssl libpcap-dev tzdata wget unzip procps util-linux && \
    VAULT_GPGKEY=C874011F0AB405110D02105534365D9472D7468F; \
    found=''; \
    for server in \
        hkp://p80.pool.sks-keyservers.net:80 \
        hkp://keyserver.ubuntu.com:80 \
        hkp://pgp.mit.edu:80 \
    ; do \
        echo "Fetching GPG key $VAULT_GPGKEY from $server"; \
        gpg --batch --keyserver "$server" --recv-keys "$VAULT_GPGKEY" && found=yes && break; \
    done; \
    test -z "$found" && echo >&2 "error: failed to fetch GPG key $VAULT_GPGKEY" && exit 1; \
    mkdir -p /tmp/build && \
    cd /tmp/build && \
    wget https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip && \
    wget https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_SHA256SUMS && \
    wget https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_SHA256SUMS.sig && \
    gpg --batch --verify vault_${VAULT_VERSION}_SHA256SUMS.sig vault_${VAULT_VERSION}_SHA256SUMS && \
    grep vault_${VAULT_VERSION}_linux_amd64.zip vault_${VAULT_VERSION}_SHA256SUMS | sha256sum -c && \
    unzip -d /bin vault_${VAULT_VERSION}_linux_amd64.zip && \
    cd /tmp && \
    rm -rf /tmp/build && \
    gpgconf --kill dirmngr && \
    gpgconf --kill gpg-agent && \
    rm -rf /root/.gnupg

# install ansible dependencies: kubernetes, hashicorp vault, community
RUN ansible-galaxy collection install kubernetes.core && \
	ansible-galaxy install 'git+https://github.com/TerryHowe/ansible-modules-hashivault.git' && \
	ansible-galaxy collection install community.general

# set necessary environment variables
ENV ANSIBLE_LIBRARY "${HOME}/.local/lib/python3.9/site-packages/ansible/modules"
ENV ANSIBLE_MODULE_UTILS "${HOME}/.local/lib/python3.9/site-packages/ansible/module_utils"

WORKDIR /

COPY docker-entrypoint.sh .


ENTRYPOINT [ "/docker-entrypoint.sh" ]


all: ca.pem ssh

# generate your own self signed certificate
ca.pem:
	openssl req -newkey rsa:2048 -new -nodes -x509 -days 3650 -keyout ca-key.pem -out ca-cert.pem
	cat ca-cert.pem >> ca.pem
	cat ca-key.pem >> ca.pem
	rm ca-cert.pem
	rm ca-key.pem


ssh:
	ssh-keygen -t rsa -b 4096 -q -N "" -f ssh

clean:
	-rm ca.pem
	-rm ssh
	-rm ssh.pub
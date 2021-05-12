

# generate your own self signed certificate
ca.pem:
	openssl req -newkey rsa:2048 -new -nodes -x509 -days 3650 -keyout key.pem -out cert.pem
	cat cert.pem >> ca.pem
	cat key.pem >> ca.pem
	rm cert.pem
	rm key.pem
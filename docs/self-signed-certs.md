**Creating selfsigned certs**
```mkdir cert
cd certs
openssl genrsa -out "root-ca.key" 4096
openssl req \
       -new -key "root-ca.key" \
       -out "root-ca.csr" -sha256 \
       -subj '/C=IN/ST=KA/L=Bengaluru/O=Sunbird/CN=Sunbird Example CA'
vim root-ca.cnf
openssl x509 -req  -days 3650  -in "root-ca.csr" \
            -signkey "root-ca.key" -sha256 -out "root-ca.crt" \
            -extfile "root-ca.cnf" -extensions \
            root_ca
openssl genrsa -out "site.key" 4096
openssl req -new -key "site.key" -out "site.csr" -sha256 \
      -subj '/C=US/ST=CA/L=San Francisco/O=Docker/CN=localhost'

vim site.cnf 

openssl x509 -req -days 750 -in "site.csr" -sha256 \
-CA "root-ca.crt" -CAkey "root-ca.key"  -CAcreateserial \
-out "site.crt" -extfile "site.cnf" -extensions server
```

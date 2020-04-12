# Self Signed Certificates

## SSL localhost

See: https://gist.github.com/cecilemuller/9492b848eb8fe46d462abeb26656c4f8
See: https://www.humankode.com/ssl/create-a-selfsigned-certificate-for-nginx-in-5-minutes
See: https://medium.com/@pubudu538/how-to-create-a-self-signed-ssl-certificate-for-multiple-domains-25284c91142b

https://docs.zaphq.io/docs-desktop-lnd-configure

No need to do this

```
lnd --tlsextradomain=lnd.radicle.local --tlsextradomain=docker.for.mac.localhost
rm ~/Library/Application\ Support/Lnd/tls.*
lndstart-alice
lncli-alice unlock
cp $HOME/Library/Application\ Support/Lnd/tls.cert $HOME/hubgit/radicle-solutions/ms-lsat/src/main/resources/static/radicle_local.cert
cp data/chain/bitcoin/testnet/admin.macaroon /Users/mikey/hubgit/radicle-solutions/ms-lsat/src/main/resources/static/alice.admin.macaroon
```

Not necessary to do the following as lnd doesn't recognise the certificate but included here for completeness...

```
openssl x509 -text -noout -in $HOME/Library/Application\ Support/Lnd/tls.cert
openssl ecparam -genkey -name prime256v1 -out radicle.key
openssl req -new -sha256 -key radicle.key -out radicle.csr  -config localhost.conf
openssl req -x509 -sha256 -days 7200 -key radicle.key  -in radicle.csr  -out radicle.cert
cp radicle.key $HOME/Library/Application\ Support/Lnd/tls.key
cp radicle.cert $HOME/Library/Application\ Support/Lnd/tls.cert
cp radicle.cert $HOME/hubgit/radicle-solutions/ms-lsat/src/main/resources/static/radicle_local.cert
```

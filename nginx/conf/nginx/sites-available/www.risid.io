server {
	listen 80;
	server_name risid.io www.risid.io;
	location ^~ /.well-known {
      allow all;
      root  /data/letsencrypt/;
    }
	location / {
      return 301 https://risidio.com$request_uri;
	}
}
server {
 	listen 443 ssl http2;
 	listen [::]:443 ssl http2;
	server_name www.risid.io;

    ssl_certificate /etc/letsencrypt/live/radsoc-certs/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/radsoc-certs/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

	return 301 https://risidio.com$request_uri;
}
server {
	server_name risid.io;
 	listen 443 ssl;
	root   /var/www/brightblock-radsoc;
	underscores_in_headers on;

    ssl_certificate /etc/letsencrypt/live/radsoc-certs/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/radsoc-certs/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

	return 301 https://risidio.com$request_uri;
}

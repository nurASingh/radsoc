server {
			listen 80;
			listen [::]:80;
			server_name login.risidio.com;
			location ^~ /.well-known {
		      allow all;
		      root  /data/letsencrypt/;
		  }
			location / {
      	return 301 https://$host$request_uri;
			}
}
server {
	server_name login.risidio.com;
 	listen 443 ssl http2;
 	listen [::]:443 ssl http2;
	root /var/www/fallback;
  ssl_certificate /etc/letsencrypt/live/radsoc-certs/fullchain.pem; # managed by Certbot
  ssl_certificate_key /etc/letsencrypt/live/radsoc-certs/privkey.pem; # managed by Certbot
  include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
  ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
	keepalive_timeout   70;
	index  index.html index.htm;
	include /etc/nginx/include.proxying;
	include /etc/nginx/include.cors;

#	location ~* ^\/(.*) {
#	    proxy_pass http://keycloak;
#	}
}

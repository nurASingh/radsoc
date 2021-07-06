server {
  listen 80;
	listen [::]:80;
	server_name api.risidio.com;
	location ^~ /.well-known {
      allow all;
      root  /data/letsencrypt/;
  	}
	location / {
      return 301 https://$host$request_uri;
	}
}
server {
	server_name api.risidio.com;
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

	location ~* ^\/mesh/(.*) {
	    proxy_pass http://mesh;
			include /etc/nginx/include.cors2;
	}
	location ~* ^\/stacksmate/(.*) {
	    proxy_pass http://stacksmate;
			include /etc/nginx/include-restricted.cors;
	}
	location ~* ^\/assets/(.*) {
	    proxy_pass http://assets;
			include /etc/nginx/include.cors2;
	}
	location ~* ^\/index/(.*) {
	    proxy_pass http://search;
			include /etc/nginx/include.cors2;
	}
	location ~* ^\/lsat/ws1/(.*) {
	  proxy_pass http://lsat;
    include /etc/nginx/include.cors2;
	}
	location ~* ^\/lsat/(.*) {
	    proxy_pass http://lsat;
			include /etc/nginx/include.cors2;
	}
#	location ~* ^\/(.*) {
#	    proxy_pass http://keycloak;
#			include /etc/nginx/include.cors2;
#	}

	error_page 404 /custom_404.html;
	location = /custom_404.html {
		internal;
	}
	error_page 500 502 503 504 /custom_50x.html;
	location = /custom_50x.html {
		internal;
	}

	location /testing {
		fastcgi_pass unix:/does/not/exist;
	}
}

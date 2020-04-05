server {
	listen 80;
	server_name *.assets.com;
	location /.well-known/acme-challenge/ {
	    root /var/www/certbot;
	}
	location / {
      return 301 https://$host$request_uri;
	}
}
server {
	server_name *.assets.com;
 	listen 443 ssl;
	root /var/www/assets;
	include /etc/nginx/include.proxying;
	ssl_certificate /etc/letsencrypt/live/assets.com/fullchain.pem;
	ssl_certificate_key /etc/letsencrypt/live/assets.com/privkey.pem;
	include /etc/letsencrypt/options-ssl-nginx.conf;
	ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

	keepalive_timeout   70;
	index  index.html index.htm;

	# Cors headers needed to fetch manifest file!
	location / {
	   	try_files $uri $uri/ /index.html;
			proxy_cache my_cache;
      include /etc/nginx/include.cors;
	}
	error_page 404 /custom_404.html;
	location = /custom_404.html {
		root /var/www/fallback;
	}
	error_page 500 502 503 504 /custom_50x.html;
	location = /custom_50x.html {
		root /var/www/fallback;
	}
}

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
	underscores_in_headers on;
	ssl_certificate /etc/letsencrypt/live/assets.com/fullchain.pem;
	ssl_certificate_key /etc/letsencrypt/live/assets.com/privkey.pem;
	include /etc/letsencrypt/options-ssl-nginx.conf;
	ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

	keepalive_timeout   70;
	index  index.html index.htm;
	proxy_set_header X-Forwarded-Host $host;
	proxy_set_header X-Forwarded-Server $host;
	proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	error_page 404 /custom_404.html;

	# Cors headers needed to fetch manifest file!
	location / {
	   	try_files $uri $uri/ /index.html;
		proxy_cache my_cache;
		add_header 'Access-Control-Allow-Origin' "*" always;
		add_header 'Access-Control-Allow-Credentials' 'true' always;
		add_header 'Access-Control-Allow-Methods' 'GET, POST, PUT, DELETE, OPTIONS' always;
		add_header 'Access-Control-Allow-Headers' 'Accept,Authorization,Cache-Control,Content-Type,DNT,If-Modified-Since,Keep-Alive,Origin,User-Agent,X-Requested-With' always;
	}
	location = /custom_404.html {
		internal;
	}
	error_page 500 502 503 504 /custom_50x.html;
	location = /custom_50x.html {
		internal;
	}
}

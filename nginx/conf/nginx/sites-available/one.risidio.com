server {
	listen 80;
	listen [::]:80;
	server_name one.risidio.com;
	location ^~ /.well-known {
      allow all;
      root  /data/letsencrypt/;
    }
	location / {
      return 301 https://one.risidio.com$request_uri;
	}
}
server {
	server_name one.risidio.com;
 	listen 443 ssl;
	listen [::]:443 ssl http2;
	root   /var/www/one;
	underscores_in_headers on;

    ssl_certificate /etc/letsencrypt/live/radsoc-certs/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/radsoc-certs/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

   	keepalive_timeout   70;
	index  index.html index.htm;
	proxy_set_header X-Forwarded-Host $host;
	proxy_set_header X-Forwarded-Server $host;
	proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	error_page 404 /custom_404.html;

	# Cors headers needed for blockstack to fetch manifest file!
	location / {
	   	try_files $uri $uri/ /index.html;
		proxy_cache my_cache;
		add_header 'can\'t-be-evil' "true";
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

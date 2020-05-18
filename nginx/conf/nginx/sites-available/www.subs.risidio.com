server {
	listen 80;
	server_name vote.risidio.com;
	location ^~ /.well-known {
      allow all;
      root  /data/letsencrypt/;
    }
	location / {
      return 301 https://vote.risidio.com$request_uri;
	}
}
server {
	listen 80;
	server_name digital.risidio.com;
	location ^~ /.well-known {
      allow all;
      root  /data/letsencrypt/;
    }
	location / {
      return 301 https://digital.risidio.com$request_uri;
	}
}
server {
	listen 80;
	server_name physical.risidio.com;
	location ^~ /.well-known {
      allow all;
      root  /data/letsencrypt/;
    }
	location / {
      return 301 https://physical.risidio.com$request_uri;
	}
}
server {
	server_name vote.risidio.com;
 	listen 443 ssl;
	root   /var/www/risidio402;
  ssl_certificate /etc/letsencrypt/live/radsoc-certs/fullchain.pem; # managed by Certbot
  ssl_certificate_key /etc/letsencrypt/live/radsoc-certs/privkey.pem; # managed by Certbot
  include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
  ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
  keepalive_timeout   70;
	index  index.html index.htm;
	include /etc/nginx/include.proxying;
	include /etc/nginx/include.cors;

	# Cors headers needed for blockstack to fetch manifest file!
	location / {
	  try_files $uri $uri/ /index.html;
		proxy_cache my_cache;
	}
	error_page 404 /custom_404.html;
	location = /custom_404.html {
		internal;
	}
	error_page 500 502 503 504 /custom_50x.html;
	location = /custom_50x.html {
		internal;
	}
}
server {
	server_name physical.risidio.com;
 	listen 443 ssl;
	root   /var/www/risidio402;
  ssl_certificate /etc/letsencrypt/live/radsoc-certs/fullchain.pem; # managed by Certbot
  ssl_certificate_key /etc/letsencrypt/live/radsoc-certs/privkey.pem; # managed by Certbot
  include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
  ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
  keepalive_timeout   70;
	index  index.html index.htm;
	include /etc/nginx/include.proxying;
	include /etc/nginx/include.cors;

	# Cors headers needed for blockstack to fetch manifest file!
	location / {
	  try_files $uri $uri/ /index.html;
		proxy_cache my_cache;
	}
	error_page 404 /custom_404.html;
	location = /custom_404.html {
		internal;
	}
	error_page 500 502 503 504 /custom_50x.html;
	location = /custom_50x.html {
		internal;
	}
}
server {
	server_name digital.risidio.com;
 	listen 443 ssl;
	root   /var/www/risidio402;
  ssl_certificate /etc/letsencrypt/live/radsoc-certs/fullchain.pem; # managed by Certbot
  ssl_certificate_key /etc/letsencrypt/live/radsoc-certs/privkey.pem; # managed by Certbot
  include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
  ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
  keepalive_timeout   70;
	index  index.html index.htm;
	include /etc/nginx/include.proxying;
	include /etc/nginx/include.cors;

	# Cors headers needed for blockstack to fetch manifest file!
	location / {
	  try_files $uri $uri/ /index.html;
		proxy_cache my_cache;
	}
	error_page 404 /custom_404.html;
	location = /custom_404.html {
		internal;
	}
	error_page 500 502 503 504 /custom_50x.html;
	location = /custom_50x.html {
		internal;
	}
}

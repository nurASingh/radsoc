server {
	listen 80;
	listen [::]:80;
	server_name metrics.risidio.com;
	location ^~ /.well-known {
      allow all;
      root  /data/letsencrypt/;
    }
	location / {
      return 301 https://$host$request_uri;
	}
}
server {
	server_name metrics.risidio.com;
 	listen 443 ssl http2;
 	listen [::]:443 ssl http2;
	root /var/www/fallback;
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

	location ~* ^\/(.*) {
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_http_version 1.1;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $host;
        proxy_pass http://grafana;
  	}

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
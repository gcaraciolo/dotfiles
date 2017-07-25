server {
  listen 80;
  server_name local.api.website.com;

  location / {
    proxy_pass http://localhost:3000;
  }
}

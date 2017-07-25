server {
  listen 80;
  server_name local.website.com;

  location / {
    root workspace/website;
    index index.html index.htm index.php; 
  }
}

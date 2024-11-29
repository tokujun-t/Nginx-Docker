# How to use

Start by orchestrating your web application by editing nginx.conf.

Then, in a production environment you can use the script to install the environment:

```shell
wget https://raw.githubusercontent.com/tokujun-t/Nginx-Docker/refs/heads/main/install.sh
sudo sh install.sh
```

In the development environment, you can test your orchestration by simply executing `docker compose up`.

# Some tips

### Create self-signed crt
```shell
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/default.key \
    -out /etc/nginx/ssl/default.crt \
    -subj "/C=US/ST=Test/L=Test/O=Test/OU=Test/CN=default"
```

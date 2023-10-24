
#!/usr/bin/bash

new_ip=$(curl -s ifconfig.me)
nginx_conf="/home/ubuntu/blogprojectdrf/nginx/nginx.conf"
old_ip=$(grep -oP 'server_name \K[^;]+' $nginx_conf)

sed -i "s/server_name $old_ip;/server_name $new_ip;/" $nginx_conf

sudo systemctl daemon-reload
sudo rm -f /etc/nginx/sites-enabled/default

sudo cp /home/ubuntu/blogprojectdrf/nginx/nginx.conf /etc/nginx/sites-available/blog
sudo ln -s /etc/nginx/sites-available/blog /etc/nginx/sites-enabled/
#sudo ln -s /etc/nginx/sites-available/blog /etc/nginx/sites-enabled
#sudo nginx -t
sudo gpasswd -a www-data ubuntu
sudo systemctl restart nginx


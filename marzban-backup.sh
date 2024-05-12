#!/bin/bash

#Здесь заданы переменные, отвечающие за время
current_date=$(date +"%d-%m-%Y")
current_month=$(date +"%m")
current_day=$(date +"%d")
current_year=$(date +"%Y")
current_time=$(date +"%H-%M")

#Переменная, значение которой - IP адрес
server_ip=$(hostname -I | awk '{print $1}')

#Логика построения каталов бэкапа по принципу: s3:ip_add/year/month/day/time_date.zip
remote_dir="${current_year}/${current_month}/${current_day}"
backup_name="${current_time}_${current_date}.zip"

#Бэкап каталогов за исключением access.log
zip -r "$backup_name" /var/lib/marzban /opt/marzban -x /var/lib/marzban/access.log

#Бэкап сразу на 3 разных хранилища
rclone copy "$backup_name" srv1:backup/"$server_ip"/"$remote_dir"/
rclone copy "$backup_name" srv2:backup/"$server_ip"/"$remote_dir"/
rclone copy "$backup_name" srv3:backup/"$server_ip"/"$remote_dir"/

#Удаление локального архива
rm "$backup_name"

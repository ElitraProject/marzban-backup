# Bash-скрипт бэкапа Marzban
Бэкап каталогов панели Marzban на ваши удаленные хранилища через rclone.
## Установка
1. Установите необходимые пакеты: 
```sh
sudo apt update && apt upgrade && apt install -y rclone wget nano crontab
```
2. Скачайте скрипт командой:

```sh
wget -N https://raw.githubusercontent.com/ElitraProject/marzban-backup/main/marzban-backup.sh
```
3. Откройте скрипт с помощью редактора **nano** (или любым удобным вам):
```sh
nano marzban-backup.sh
```
4. Отредактируйте путь, куда следует бэкапить ваш архив, а именно **"srv:backup"**:
```sh
20 | #Бэкап сразу на 3 разных хранилища
21 | rclone copy "$backup_name" srv1:backup/"$server_ip"/"$remote_dir"/
22 | rclone copy "$backup_name" srv2:backup/"$server_ip"/"$remote_dir"/
23 | rclone copy "$backup_name" srv3:backup/"$server_ip"/"$remote_dir"/
```
5. Выдайте права на исполнение скрипта командой:
```sh
chmod +x marzban-backup.sh
```
6. Проверьте работу скрипта её запуском:
```sh
./marzban-backup.sh
```
7. Автоматизируйте скрипт с помощью **crontab**:
```sh
crontab -e 
```
А затем внесите значения (в качестве примера скрипт будет выполняться каждые **3 часа**, в интернете полно калькуляторов для crontab, сможете подобрать своё значение): 
```sh
0 */3 * * * /директория/скрипта/marzban-backup.sh
```
Выйдите из редактора сохранив изменения.

## Итого
Путь бэкапа будет таким:
```sh
your-server:backup/2024/05/13/12-00_13-05-2024.zip
```

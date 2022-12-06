@ECHO OFF
:: Останавливает контейнер и удаляет его

:: Устанавливает заголовок окна
TITLE Run "docker STOP and REMOVE"

:: Останавливает контейнер
docker stop advertisement_db

:: Выводит логи контейнера
docker logs advertisement_db

:: Удаляет контейнер
docker rm /advertisement_db

:: Выводит список запущенных контейнеров
docker ps

PAUSE

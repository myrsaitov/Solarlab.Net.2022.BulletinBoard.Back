@ECHO OFF
:: Останавливает контейнер и удаляет его

:: Устанавливает заголовок окна
TITLE Run "docker STOP and REMOVE"

:: Останавливает контейнер
docker stop advertisement_container

:: Выводит логи контейнера
docker logs advertisement_container

:: Удаляет контейнер
docker rm /advertisement_container

:: Выводит список запущенных контейнеров
docker ps

PAUSE

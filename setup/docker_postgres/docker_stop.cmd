@ECHO OFF
:: Останавливает контейнер

:: Устанавливает заголовок окна
TITLE Run "docker STOP"

:: Останавливает контейнер
docker stop advertisement_db

:: Удаляет контейнер
docker logs advertisement_db

:: Выводит список запущенных контейнеров
docker ps

PAUSE

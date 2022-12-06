@ECHO OFF
:: Останавливает контейнер

:: Устанавливает заголовок окна
TITLE Run "docker STOP"

:: Останавливает контейнер
docker stop advertisement_container

:: Удаляет контейнер
docker logs advertisement_container

:: Выводит список запущенных контейнеров
docker ps

PAUSE

@ECHO OFF
:: Получает образ с docker-hub

:: Устанавливает заголовок окна
TITLE Run "docker pull postgres"

:: Получает образ с docker-hub
docker pull postgres

PAUSE

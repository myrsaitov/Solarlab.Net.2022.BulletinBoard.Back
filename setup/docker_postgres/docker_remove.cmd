@ECHO OFF
:: Удаляет контейнер

:: Устанавливает заголовок окна
TITLE Run "docker RM"

:: Удаляет контейнер
docker rm /advertisement_container

PAUSE

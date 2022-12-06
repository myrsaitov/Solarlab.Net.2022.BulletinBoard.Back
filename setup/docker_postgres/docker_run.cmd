@ECHO OFF
:: Запускает контейннер из образа

:: Устанавливает заголовок окна
TITLE Run "docker RUN"

:: Запускает контейннер из образа
:: В строке "-p Port1:Port2": маппинг портов: Port 1 - реальный порт на хосте, "Port 2" - порт внутри контейнера
docker run --name advertisement_container^
           -e POSTGRES_USER=advertisement_user^
           -e POSTGRES_PASSWORD=Kg1xh3xXFpg4^
           -e POSTGRES_DB=advertisement_db^
           -p 49002:5432^
           -v c:/Docker/Root/advertisement_container/largedb:/mnt/largedb^
           -d postgres

:: Запускает контейннер из образа
docker logs advertisement_container

:: Выводит список запущенных контейнеров
docker ps

PAUSE

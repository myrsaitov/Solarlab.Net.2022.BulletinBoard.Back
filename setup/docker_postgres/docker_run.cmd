@ECHO OFF
:: Запускает контейннер из образа

:: Устанавливает заголовок окна
TITLE Run "docker RUN"

docker run --name advertisement_db -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=advertisement_db -d -p 5432:5432 -v c:/DockerMount/advertisement_db/largedb:/mnt/largedb postgres

docker logs advertisement_db

docker ps

PAUSE

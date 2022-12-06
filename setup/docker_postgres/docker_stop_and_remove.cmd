@ECHO OFF
:: Запускает контейннер из образа

:: Переходит в рабочую папку
CD ./../../../Docker/V1/Postgres

:: Вызывает процедуру с параметрами
CALL docker_stop_and_remove.cmd 15.1 net2022_advertisement

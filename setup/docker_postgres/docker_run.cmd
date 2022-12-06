@ECHO OFF
:: Запускает контейннер из образа

:: Переходит в рабочую папку
CD ./../../../Docker/V1/Postgres

:: Вызывает процедуру с параметрами
CALL docker_run.cmd 15.1 49002 net2022 advertisement

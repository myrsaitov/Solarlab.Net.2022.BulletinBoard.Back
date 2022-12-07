@ECHO OFF
:: Останавливает и удаляет контейннер

:: Переходит в рабочую папку
CD ./../../../Docker/V1/Postgres

:: Вызывает процедуру с параметрами
CALL docker_stop_and_remove.cmd 15.1 net2022 advertisement

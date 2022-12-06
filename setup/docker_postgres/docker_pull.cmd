@ECHO OFF
:: Скачивает образ postgres указанной версии

:: Переходит в рабочую папку
CD ./../../../Docker/V1/Postgres

:: Вызывает процедуру с параметрами
CALL docker_pull.cmd 15.1

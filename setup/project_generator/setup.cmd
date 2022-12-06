@ECHO OFF
:: Создаёт набор микросервисов

:: Устанавливает заголовок окна
TITLE Run "Project Setup"

:: Переход в корневую папку проекта
CD ./../../

:: Создает Solution
IF NOT EXIST BulletinBoard.sln dotnet new sln --name BulletinBoard

:: Запоминает корневую папку
SET ROOT_PATH=%CD%

:: Переходит в рабочую папку
CD setup/project_generator/__private

:: Создает микросервис
::CALL __add_microservice.cmd %ROOT_PATH% Accounts

:: Создает микросервис
CALL __add_microservice.cmd %ROOT_PATH% Advertisements

:: Создает микросервис
::CALL __add_microservice.cmd %ROOT_PATH% Comments

:: Создает микросервис
::CALL __add_microservice.cmd %ROOT_PATH% UserFiles

PAUSE

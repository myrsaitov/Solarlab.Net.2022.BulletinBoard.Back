@ECHO OFF
:: Добавляет миграцию

:: Устанавливает заголовок окна
TITLE "Adding new migration"

:: Имя проекта
SET PROJECT_NAME=Advertisements

:: Подготовка параметров
SET STARTUP_PROJECT=--startup-project src/%PROJECT_NAME%/Hosts/%PROJECT_NAME%.Api/%PROJECT_NAME%.Api.csproj
SET PROJECT=--project src/%PROJECT_NAME%/Infrastructure/%PROJECT_NAME%.DataAccess/%PROJECT_NAME%.DataAccess.csproj
SET PARAMS=%STARTUP_PROJECT% %PROJECT%

:: Добавляет миграцию
:: dotnet ef migrations add %PARAMS% Initial_Create 
   dotnet ef migrations add %PARAMS% SecondMigration 

PAUSE

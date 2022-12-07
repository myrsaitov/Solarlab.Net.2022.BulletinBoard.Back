@ECHO OFF
:: Обновляет базу данных

:: Устанавливает заголовок окна
TITLE "Updating Data Base"

SET PROJECT_NAME=Advertisements

:: Обновляет базу данных
:: Можно указать имя нужной миграции: dotnet ef database update %MigrationName%
dotnet ef database update^
    --startup-project  src\%PROJECT_NAME%\Hosts\%PROJECT_NAME%.Api/%PROJECT_NAME%.Api.csproj^
    --project src\%PROJECT_NAME%\Infrastructure\%PROJECT_NAME%.DataAccess\%PROJECT_NAME%.DataAccess.csproj
 
PAUSE

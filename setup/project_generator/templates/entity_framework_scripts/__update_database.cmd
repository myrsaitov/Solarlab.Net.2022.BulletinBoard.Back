@ECHO OFF
:: Обновляет базу данных

:: Устанавливает заголовок окна
TITLE "Updating Data Base"

:: Обновляет базу данных
:: Можно указать имя нужной миграции: dotnet ef database update %MigrationName%
dotnet ef database update

PAUSE

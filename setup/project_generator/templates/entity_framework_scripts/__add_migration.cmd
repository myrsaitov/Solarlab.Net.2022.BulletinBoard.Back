@ECHO OFF
:: Добавляет миграцию

:: Устанавливает заголовок окна
TITLE "Adding new migration"

:: Добавляет миграцию
:: dotnet ef migrations add Initial_Create
dotnet ef migrations add SecondMigration

PAUSE

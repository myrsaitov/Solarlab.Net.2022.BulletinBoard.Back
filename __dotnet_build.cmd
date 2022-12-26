@ECHO OFF
:: Выполняет сборку проекта

:: Заголовок окна - путь и имя файла
TITLE %~0

:: Выполняет сборку проекта
:: https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-build
dotnet build -f net6.0

PAUSE

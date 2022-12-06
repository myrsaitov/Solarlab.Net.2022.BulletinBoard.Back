@ECHO OFF
:: Выполняет сборку проекта

:: Устанавливает заголовок окна
TITLE Run "dotnet BUILD"

:: Выполняет сборку проекта
:: https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-build
dotnet build -f net6.0

PAUSE

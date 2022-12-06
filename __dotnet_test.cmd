@ECHO OFF
:: Выполняет исходный код без дополнительных явных команд компиляции или запуска

:: Устанавливает заголовок окна
TITLE Run "dotnet TEST"

:: Выполняет исходный код без дополнительных явных команд компиляции или запуска
:: https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-test
dotnet test

PAUSE

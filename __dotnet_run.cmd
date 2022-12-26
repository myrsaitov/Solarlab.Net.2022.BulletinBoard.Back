@ECHO OFF
:: Выполняет исходный код без дополнительных явных команд компиляции или запуска

:: Заголовок окна - путь и имя файла
TITLE %~0

:: Выполняет исходный код без дополнительных явных команд компиляции или запуска
:: https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-run
dotnet run --project src/Main/Main.csproj

PAUSE

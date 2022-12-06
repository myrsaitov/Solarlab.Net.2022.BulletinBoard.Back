@ECHO OFF
:: Выполняет исходный код без дополнительных явных команд компиляции или запуска

:: Устанавливает заголовок окна
TITLE Run "dotnet RUN"

:: Выполняет исходный код без дополнительных явных команд компиляции или запуска
:: https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-run
dotnet run --project src/Main/Main.csproj

PAUSE

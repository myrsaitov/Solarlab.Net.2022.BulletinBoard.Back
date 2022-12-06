@ECHO OFF
:: Перезапускает или перезагружает указанное приложение при обнаружении изменений в исходном коде

:: Устанавливает заголовок окна
TITLE Run "dotnet WATCH"

:: Перезапускает или перезагружает указанное приложение при обнаружении изменений в исходном коде
:: https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-watch
dotnet watch --project src/Main/Main.csproj run

PAUSE

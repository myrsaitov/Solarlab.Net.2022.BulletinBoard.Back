@ECHO OFF
:: Устанавливает версию SDK по умолчанию

:: Устанавливает заголовок окна
TITLE Run "dotnet SDK default"

:: Устанавливает версию SDK по умолчанию
:: https://learn.microsoft.com/ru-ru/dotnet/core/tools/global-json
dotnet new globaljson --sdk-version 6.0

PAUSE

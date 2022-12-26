@ECHO OFF
:: Устанавливает версию SDK по умолчанию

:: Заголовок окна - путь и имя файла
TITLE %~0

:: Устанавливает версию SDK по умолчанию
:: https://learn.microsoft.com/ru-ru/dotnet/core/tools/global-json
dotnet new globaljson --sdk-version 6.0

PAUSE

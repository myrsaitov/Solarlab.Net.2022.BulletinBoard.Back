@ECHO OFF
:: Выводит информацию об имеющихся в системе SDK

:: Устанавливает заголовок окна
TITLE Run "dotnet SDK info"

:: Выводит информацию об имеющихся в системе SDK

ECHO default SDK:
dotnet --version

ECHO all SDKs:
dotnet --list-sdks

ECHO all Runtimes:
dotnet --list-runtimes

PAUSE

@ECHO OFF
:: Создаёт набор проектов для микросервиса
:: %1 - путь к файлу Solution
:: %2 - имя микросервиса

:: Переход в корневую папку Solution
CD %~1

:: Проверяет, если существует папка с микросервисом, то отмена
IF EXIST src/%~2 (
    
    ECHO The folder "%~2" exists. Nothing to do. Delete it if you want to update.
	CD setup/__private
	PAUSE
    EXIT /B 0

) 


::===========================================================
:: Контракты
::===========================================================

    :: Создает библиотеку
    CALL :DotNetNew Contracts %~2 Contracts classlib || EXIT /B 1

    :: Добавляет NuGet
    CALL :DotNetAddPackage Contracts %~2 Contracts Microsoft.AspNetCore.Mvc.Formatters.Json || EXIT /B 1
    CALL :DotNetAddPackage Contracts %~2 Contracts Microsoft.AspNetCore || EXIT /B 1
    CALL :DotNetAddPackage Contracts %~2 Contracts Microsoft.AspNetCore.Authorization || EXIT /B 1
    ::CALL :DotNetAddPackage Contracts %~2 Contracts Microsoft.AspNetCore.Authentication.JwtBearer || EXIT /B 1


::===========================================================
:: Слой домена
::===========================================================

    :: Создает библиотеку
    CALL :DotNetNew Domain %~2 Domain classlib || EXIT /B 1

    :: Добавляет NuGet
    CALL :DotNetAddPackage Domain %~2 Domain FluentValidation || EXIT /B 1


::===========================================================
:: Слой инфраструктуры
::===========================================================

    :: Создает библиотеку "DataAccess"
    CALL :DotNetNew Infrastructure %~2 DataAccess classlib || EXIT /B 1
    
    :: Добавляет NuGet
    CALL :DotNetAddPackage Infrastructure %~2 DataAccess Microsoft.EntityFrameworkCore || EXIT /B 1
    CALL :DotNetAddPackage Infrastructure %~2 DataAccess Microsoft.EntityFrameworkCore.Abstractions || EXIT /B 1
    CALL :DotNetAddPackage Infrastructure %~2 DataAccess Microsoft.EntityFrameworkCore.Design || EXIT /B 1
    CALL :DotNetAddPackage Infrastructure %~2 DataAccess Microsoft.EntityFrameworkCore.SqlServer || EXIT /B 1
    CALL :DotNetAddPackage Infrastructure %~2 DataAccess Microsoft.Extensions.Configuration.Binder || EXIT /B 1
    CALL :DotNetAddPackage Infrastructure %~2 DataAccess Npgsql.EntityFrameworkCore.PostgreSQL || EXIT /B 1
    CALL :DotNetAddPackage Infrastructure %~2 DataAccess Npgsql.EntityFrameworkCore.PostgreSQL.Design || EXIT /B 1


    :: Создает библиотеку "Infrastructure"
    CALL :DotNetNew Infrastructure %~2 Infrastructure classlib || EXIT /B 1
    :: Добавляет NuGet
    CALL :DotNetAddPackage Infrastructure %~2 Infrastructure Microsoft.EntityFrameworkCore || EXIT /B 1

    :: Создает библиотеку "Migrations"
    CALL :DotNetNew Infrastructure %~2 Migrations classlib || EXIT /B 1
    
    :: Добавляет NuGet
    CALL :DotNetAddPackage Infrastructure %~2 Migrations Microsoft.EntityFrameworkCore.Tools || EXIT /B 1
    CALL :DotNetAddPackage Infrastructure %~2 Migrations Microsoft.EntityFrameworkCore.Design || EXIT /B 1
    CALL :DotNetAddPackage Infrastructure %~2 Migrations Microsoft.Extensions.Configuration || EXIT /B 1
    CALL :DotNetAddPackage Infrastructure %~2 Migrations Microsoft.Extensions.Configuration.Json || EXIT /B 1
    
    :: Копирует скрипты для работы с Entity Framework
    COPY .\setup\project_generator\templates\entity_framework_scripts\__add_migration.cmd .\src\%~2\Infrastructure\%~2.Migrations\__add_migration.cmd
    COPY .\setup\project_generator\templates\entity_framework_scripts\__update_database.cmd .\src\%~2\Infrastructure\%~2.Migrations\__update_database.cmd
    

    :: Создает библиотеку "Registrar"
    CALL :DotNetNew Infrastructure %~2 Registrar classlib || EXIT /B 1
    
    : Добавляет NuGet
    CALL :DotNetAddPackage Infrastructure %~2 Registrar Microsoft.EntityFrameworkCore || EXIT /B 1
    CALL :DotNetAddPackage Infrastructure %~2 Registrar Microsoft.Extensions.DependencyInjection.Abstractions || EXIT /B 1


::===========================================================
:: Слой бизнес-логики
::===========================================================

    :: Создает библиотеку
    CALL :DotNetNew Application %~2 AppServices classlib || EXIT /B 1


::===========================================================
:: Слой представления
::===========================================================

    :: Создает библиотеку
    CALL :DotNetNew Hosts %~2 Api webapi|| EXIT /B 1

    :: 
    dotnet dev-certs https --trust

:: Добавляет ссылки на проекты
    
    :: "Infrastructure/DataAccess"
    CALL :DotNetAddReference Infrastructure %~2 DataAccess Application %~2 AppServices || EXIT /B 1
    CALL :DotNetAddReference Infrastructure %~2 DataAccess Domain %~2 Domain || EXIT /B 1
    CALL :DotNetAddReference Infrastructure %~2 DataAccess Infrastructure %~2 Infrastructure || EXIT /B 1
    
    :: "Infrastructure/Registrar"
    CALL :DotNetAddReference Infrastructure %~2 Registrar Infrastructure %~2 DataAccess || EXIT /B 1
    CALL :DotNetAddReference Infrastructure %~2 Registrar Infrastructure %~2 Infrastructure || EXIT /B 1


:: Переходит в рабочую папку
    CD setup/project_generator/__private

:: Выход (успешный)
    EXIT /B 0


:: Создает проект по шаблону и добавляет его в Solution
    GOTO :EOF
    :DotNetNew Layer Name Suffix Template

        ECHO ********************************************************
        ECHO ** Template: %~4 ** src/%~2/%~1/%~2.%~3
        ECHO ********************************************************
        ECHO;
        
        :: Создает проект по шаблону
        dotnet new %~4 --output src/%~2/%~1/%~2.%~3 --framework net6.0 || EXIT /B 1
        
        :: Удаляет автоматически сгенерированный файл "Class1.cs"
        DEL .\src\%~2\%~1\%~2.%~3\Class1.cs || EXIT /B 1
        
        :: Добавляет созданный проект в Solution
        dotnet sln add src/%~2/%~1/%~2.%~3 || EXIT /B 1
        
        ECHO;
        ECHO;
        
        EXIT /B 0


:: Подключает NuGet к проекту
    GOTO :EOF
    :DotNetAddPackage Layer Name Suffix Package

        ECHO ********************************************************
        ECHO ** Package: %~4 ** src/%~2/%~1/%~2.%~3
        ECHO ********************************************************
        ECHO;
        
        :: Подключает NuGet к проекту
        dotnet add src/%~2/%~1/%~2.%~3/%~2.%~3.csproj package %~4 --framework net6.0 || EXIT /B 1
        
        ECHO;
        ECHO;
        
        EXIT /B 0


:: Добавляет ссылку на другой проект к проекту
    GOTO :EOF
    :DotNetAddReference Laye0 Name Suffix LayerR NameR SuffixR

        ECHO ********************************************************
        ECHO ** Reference ** src/%~2/%~1/%~2.%~3
        ECHO ********************************************************
        ECHO;
        
        :: Добавляет ссылку на другой проект к проекту
        dotnet add src/%~2/%~1/%~2.%~3/%~2.%~3.csproj reference src/%~5/%~4/%~5.%~6/%~5.%~6.csproj --framework net6.0 || EXIT /B 1
        
        ECHO;
        ECHO;
        
        EXIT /B 0
        
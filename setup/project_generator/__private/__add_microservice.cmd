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

    :: Создает библиотеку "Registrar"
    CALL :DotNetNew Infrastructure %~2 Registrar classlib || EXIT /B 1
    
    : Добавляет NuGet
    CALL :DotNetAddPackage Infrastructure %~2 Registrar Microsoft.EntityFrameworkCore || EXIT /B 1
    CALL :DotNetAddPackage Infrastructure %~2 Registrar Microsoft.Extensions.DependencyInjection.Abstractions || EXIT /B 1

    :: Создает библиотеку "Mapper"
    CALL :DotNetNew Infrastructure %~2 Mapper classlib || EXIT /B 1

    :: Добавляет NuGet
    CALL :DotNetAddPackage Infrastructure %~2 Mapper Mapster || EXIT /B 1
    CALL :DotNetAddPackage Infrastructure %~2 Mapper Mapster.DependencyInjection || EXIT /B 1


::===========================================================
:: Слой бизнес-логики
::===========================================================

    :: Создает библиотеку
    CALL :DotNetNew Application %~2 AppServices classlib || EXIT /B 1

    :: Добавляет NuGet
    CALL :DotNetAddPackage Application %~2 AppServices FluentValidation || EXIT /B 1
    CALL :DotNetAddPackage Application %~2 AppServices Mapster || EXIT /B 1
    CALL :DotNetAddPackage Application %~2 AppServices Microsoft.EntityFrameworkCore || EXIT /B 1
    CALL :DotNetAddPackage Application %~2 AppServices Microsoft.EntityFrameworkCore.Design || EXIT /B 1
    CALL :DotNetAddPackage Application %~2 AppServices Microsoft.Extensions.Configuration || EXIT /B 1
    CALL :DotNetAddPackage Application %~2 AppServices Microsoft.Extensions.DependencyInjection || EXIT /B 1
    CALL :DotNetAddPackage Application %~2 AppServices Newtonsoft.Json || EXIT /B 1
    

::===========================================================
:: Слой представления
::===========================================================

    :: Создает библиотеку
    CALL :DotNetNew Hosts %~2 Api webapi|| EXIT /B 1

    :: https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-dev-certs
    :: The dotnet dev-certs https command with no options checks if a development certificate is present in the current user's certificate store on the machine
    :: "--trust" - Trusts the certificate on the local machine.
    dotnet dev-certs https --trust

    :: Добавляет NuGet
    CALL :DotNetAddPackage Application %~2 AppServices ExpressionDebugger || EXIT /B 1
    CALL :DotNetAddPackage Application %~2 AppServices HtmlAgilityPack || EXIT /B 1
    CALL :DotNetAddPackage Application %~2 AppServices Mapster || EXIT /B 1
    CALL :DotNetAddPackage Application %~2 AppServices Mapster.DependencyInjection || EXIT /B 1
    CALL :DotNetAddPackage Application %~2 AppServices Microsoft.AspNet.WebApi.Client || EXIT /B 1
    ::CALL :DotNetAddPackage Application %~2 AppServices Microsoft.AspNetCore.Authentication.JwtBearer || EXIT /B 1
    CALL :DotNetAddPackage Application %~2 AppServices Microsoft.AspNetCore.Mvc.NewtonsoftJson || EXIT /B 1
    CALL :DotNetAddPackage Application %~2 AppServices Microsoft.AspNetCore.SpaServices || EXIT /B 1
    CALL :DotNetAddPackage Application %~2 AppServices Microsoft.AspNetCore.SpaServices.Extensions || EXIT /B 1
    CALL :DotNetAddPackage Application %~2 AppServices Microsoft.CodeAnalysis || EXIT /B 1
    CALL :DotNetAddPackage Application %~2 AppServices Microsoft.EntityFrameworkCore.Design || EXIT /B 1
    CALL :DotNetAddPackage Application %~2 AppServices Microsoft.EntityFrameworkCore.Proxies || EXIT /B 1
    CALL :DotNetAddPackage Application %~2 AppServices Microsoft.TypeScript.MSBuild || EXIT /B 1
    CALL :DotNetAddPackage Application %~2 AppServices Microsoft.VisualStudio.Azure.Containers.Tools.Targets || EXIT /B 1
    CALL :DotNetAddPackage Application %~2 AppServices Swashbuckle.AspNetCore || EXIT /B 1
    CALL :DotNetAddPackage Application %~2 AppServices System.Net.Http || EXIT /B 1
    CALL :DotNetAddPackage Application %~2 AppServices System.Text.Json || EXIT /B 1
    CALL :DotNetAddPackage Application %~2 AppServices System.Threading.Tasks || EXIT /B 1
    CALL :DotNetAddPackage Application %~2 AppServices TurnerSoftware.SitemapTools || EXIT /B 1
    
    
::===========================================================
:: Слой Unit Test
::===========================================================

    :: Создает библиотеку
    CALL :DotNetNew Tests %~2 Tests classlib || EXIT /B 1

    :: Добавляет NuGet
    CALL :DotNetAddPackage Tests %~2 Tests AutoFixture.Xunit2 || EXIT /B 1
    CALL :DotNetAddPackage Tests %~2 Tests coverlet.collector || EXIT /B 1
    CALL :DotNetAddPackage Tests %~2 Tests ExpressionDebugger || EXIT /B 1
    CALL :DotNetAddPackage Tests %~2 Tests Mapster || EXIT /B 1
    CALL :DotNetAddPackage Tests %~2 Tests Microsoft.NET.Test.Sdk || EXIT /B 1
    CALL :DotNetAddPackage Tests %~2 Tests Moq  || EXIT /B 1
    CALL :DotNetAddPackage Tests %~2 Tests xunit  || EXIT /B 1
    CALL :DotNetAddPackage Tests %~2 Tests xunit.runner.visualstudio  || EXIT /B 1


:: Добавляет ссылки на проекты
:: Аргументы: Project[Layer Name Suffix] => Referense project[Layer Name Suffix]
::     => Layer Name Suffix LayerR NameR SuffixR
    
    :: "Hosts"
    CALL :DotNetAddReference Hosts %~2 Api Application %~2 AppServices || EXIT /B 1
    CALL :DotNetAddReference Hosts %~2 Api Infrastructure %~2 DataAccess || EXIT /B 1
    CALL :DotNetAddReference Hosts %~2 Api Infrastructure %~2 Mapper || EXIT /B 1
    
    :: "AppServices"
    CALL :DotNetAddReference Application %~2 AppServices Domain %~2 Domain || EXIT /B 1
    CALL :DotNetAddReference Application %~2 AppServices Contracts %~2 Contracts || EXIT /B 1
    
    :: "Domain"
    CALL :DotNetAddReference Domain %~2 Domain Contracts %~2 Contracts || EXIT /B 1
    
    :: "Infrastructure/DataAccess"
    CALL :DotNetAddReference Infrastructure %~2 DataAccess Application %~2 AppServices || EXIT /B 1
    CALL :DotNetAddReference Infrastructure %~2 DataAccess Domain %~2 Domain || EXIT /B 1
    CALL :DotNetAddReference Infrastructure %~2 DataAccess Infrastructure %~2 Infrastructure || EXIT /B 1
    
    :: "Infrastructure/Registrar"
    CALL :DotNetAddReference Infrastructure %~2 Registrar Infrastructure %~2 DataAccess || EXIT /B 1
    CALL :DotNetAddReference Infrastructure %~2 Registrar Infrastructure %~2 Infrastructure || EXIT /B 1

    :: "Infrastructure/Mapper"
    CALL :DotNetAddReference Infrastructure %~2 Mapper Application %~2 AppServices || EXIT /B 1
    CALL :DotNetAddReference Infrastructure %~2 Mapper Domain %~2 Domain || EXIT /B 1

    :: "Tests"
    CALL :DotNetAddReference Tests %~2 Tests Application %~2 AppServices || EXIT /B 1
    CALL :DotNetAddReference Tests %~2 Tests Infrastructure %~2 Mapper || EXIT /B 1

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
    :DotNetAddReference Layer Name Suffix LayerR NameR SuffixR

        ECHO ********************************************************
        ECHO ** Reference ** src/%~2/%~1/%~2.%~3
        ECHO ********************************************************
        ECHO;
        
        :: Добавляет ссылку на другой проект к проекту
        dotnet add src/%~2/%~1/%~2.%~3/%~2.%~3.csproj reference src/%~5/%~4/%~5.%~6/%~5.%~6.csproj --framework net6.0 || EXIT /B 1
        
        ECHO;
        ECHO;
        
        EXIT /B 0
        
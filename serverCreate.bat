@echo off
REM =================================================
REM =  This file is part of MC-UtilFrag, using GPL  =
REM =  https://github.com/Preta-Crowz/MC-UtilFrag   =
REM =================================================
:main
CLS
ECHO 1:Spigot	2:Forge (1.12.2)
ECHO 0:Open Github
SET /p TYPE=Select server to install :

IF %TYPE%==0 GOTO :github
IF %TYPE%==1 GOTO :spigot
IF %TYPE%==2 GOTO :forge
GOTO :end

:github
START https://github.com/Preta-Crowz/MC-UtilFrag
GOTO :main



:spigot
IF NOT EXIST BuildTools.jar (
    CLS
    ECHO BuildTools not found! Downloading new one..
    curl -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
    ECHO Downloaded BuildTools.
    TIMEOUT 5
)
SET /p VERSION=Select version to install (1.8.3~1.17.1) :
curl --head https://hub.spigotmc.org/versions/%VERSION%.json | findstr HTTP/ > %temp%\VerCheck.txt
SET /P CHECK=<%temp%\VerCheck.txt
DEL %temp%\VerCheck.txt
IF "%CHECK%"=="HTTP/1.1 404 Not Found" GOTO :vererror
CLS
ECHO Start compile.
java -jar BuildTools.jar --rev %VERSION%
ECHO Compile done.
GOTO :end



:forge
REM todo : support more versions of forge server
IF NOT EXIST ForgeInstall.jar (
    CLS
    ECHO ForgeInstall not found! Downloading new one..
    curl -o ForgeInstall.jar https://siro.dev/mirror/forge/forge-1.12.2-14.23.5.2855-installer.jar
    ECHO Downloaded ForgeInstall.
    TIMEOUT 5
)
java -jar ForgeInstall.jar --installServer
ECHO Install done.
GOTO :end


:vererror
ECHO Invalid version.
:end
ECHO Task done. Exiting..
PAUSE

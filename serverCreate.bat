REM =================================================
REM |  This file is part of MC-UtilFrag, using GPL  |
REM |  https://github.com/Preta-Crowz/MC-UtilFrag   |
REM =================================================
@echo off
:main
CLS
ECHO 0:Open Github	1:Spigot	2:Forge
SET /p TYPE=Select server to install :

IF %TYPE%==0 GOTO :github
IF %TYPE%==1 GOTO :spigot
IF %TYPE%==2 GOTO :forge
GOTO :end

:github
https://github.com/Preta-Crowz/MC-UtilFrag/new/main
GOTO :main



:spigot
IF NOT EXIST BuildTools.jar (
    CLS
    ECHO BuildTools not found! Downloading new one..
    curl -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
    ECHO Downloaded BuildTools.
    TIMEOUT 5
)
SET VER=null
ECHO 1:1.17.1	2:1.12.2
SET /p VERSION=Select version to install :
IF %VERSION%==1 SET VER=1.17.1
IF %VERSION%==2 SET VER=1.12.2
IF %VER%==null GOTO :end
CLS
ECHO Start compile.
java -jar BuildTools.jar --rev %VER%
ECHO Compile done.
TIMEOUT 5
GOTO :end



:forge
IF NOT EXIST ForgeInstall.jar (
    CLS
    ECHO ForgeInstall not found! Downloading new one..
    curl -o ForgeInstall.jar https://siro.dev/mirror/forge/forge-1.12.2-14.23.5.2855-installer.jar
    ECHO Downloaded ForgeInstall.
    TIMEOUT 5
)
java -jar ForgeInstall.jar --installServer

:end
ECHO Task done. Exiting..
PAUSE

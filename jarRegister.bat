@echo off
REM =================================================
REM =  This file is part of MC-UtilFrag, using GPL  =
REM =  https://github.com/Preta-Crowz/MC-UtilFrag   =
REM =================================================
java -version
IF %ERRORLEVEL% NEQ 0 GOTO :tryruntime
WHERE java>%temp%\JavaPath.txt
SET /P T=<%temp%\JavaPath.txt
DEL %temp%\JavaPath.txt
GOTO :work


:tryruntime
ECHO Java not detected on path! Trying Minecraft runtime..
REG QUERY "HKCU\SOFTWARE\Mojang\InstalledProducts\Minecraft Launcher" /v InstallLocation | FINDSTR InstallLocation > %temp%\Registry.txt
IF %ERRORLEVEL%==1 GOTO :nf
SET /p r= < %temp%\Registry.txt
CLS
ECHO %r:  =&ECHO.% | findstr : > %temp%\LauncherRoot.txt
SET /p root= < %temp%\LauncherRoot.txt
CD %root%
SET T=%CD%\runtime\jre-x64\bin\java.exe


:work
SET C="%T%" -jar "%%1"
REG DELETE HKCU\SOFTWARE\Classes\.jar /F
REG DELETE HKCU\SOFTWARE\Classes\openJar /F
REG ADD HKCU\SOFTWARE\Classes\.jar /F
REG ADD HKCU\SOFTWARE\Classes\.jar\OpenWithProgids /V openJar /T REG_SZ /F
REG ADD HKCU\SOFTWARE\Classes\openJar /VE /D openJar /F
REG ADD HKCU\SOFTWARE\Classes\openJar\shell /F
REG ADD HKCU\SOFTWARE\Classes\openJar\shell\open /V FriendlyAppName /T REG_SZ /D "Run jar as Java" /F
REG ADD HKCU\SOFTWARE\Classes\openJar\shell\open\command /VE /D "%C%" /F
ECHO Done.
PAUSE
EXIT


:nf
IF EXIST %temp%\JavaPath.txt DEL %temp%\JavaPath.txt
IF EXIST %temp%\Registry.txt DEL %temp%\Registry.txt
IF EXIST %temp%\LauncherRoot.txt DEL %temp%\LauncherRoot.txt
ECHO Minecraft Launcher and Java not detected!
ECHO 1) Reinstall java with path or add java to path manually.
ECHO 2) Install Minecraft Launcher and run game to install runtime.
PAUSE
EXIT

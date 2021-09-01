@echo off
REM =================================================
REM =  This file is part of MC-UtilFrag, using GPL  =
REM =  https://github.com/Preta-Crowz/MC-UtilFrag   =
REM =================================================
java -version
IF %ERRORLEVEL% NEQ 0 GOTO :nf
WHERE java>%temp%\JavaPath.txt
SET /P T=<%temp%\JavaPath.txt
DEL %temp%\JavaPath.txt
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
ECHO Java not detected! Reinstall java with path or add java to path manually.
PAUSE

@echo off

:: Ver 1.01 3-20-2025
::                    .
:: Checking to see if the Pgina software is installed on this
:: computer. 
::
:: 

SET PGINA-EXE="C:\Program Files\pGina\pGina.Configuration.exe"
SET SLEEP="C:\SysUtils\sleep_seconds.exe"

echo.
echo.
if exist %PGINA-EXE% (
     echo ...................................................................
     echo .                                                                 .
     echo .              ---[ Pgina is FOUND INSTALLED ]---                 .
     echo .                                                                 .
    echo ...................................................................
     echo.
     echo.
     echo.
     EXIT /B 1
) else (
     echo ...................................................................
     echo .                                                                 .
     echo .               ---[ Pgina is NOT INSTALLED ]---                  .
     echo .                                                                 .
     echo ...................................................................
     echo.
     echo.
     EXIT /B 0
     echo. )

:SOFTEXIT
EXIT /B 0

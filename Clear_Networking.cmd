@echo off

SET SLEEP="C:\SysUtils\sleep_seconds.exe"
SET VERIFY-PERMISSIONS-SCRIPT="C:\SysUtils\Scripts\Verify-Administrator-Privileges.cmd"

:: .
:: This script requires admin privileges
:: 

CALL %VERIFY-PERMISSIONS-SCRIPT%
if %errorLevel% NEQ 0 (
   echo.
   echo This rquires administative permissions to run.
   echo.
   goto :FAILUREMODE  )

echo ...................................................................
echo .                                                                 .
echo .                                                                 .
echo .    If you proceed, this will clear all the network settings     .
echo .                                                                 .
echo .                                                                 .
echo ...................................................................
echo.
echo.
echo.
echo Press ctrl/C to abort this script or Return to proceed
pause

netsh interface ipv4 reset
netsh interface ipv6 reset
ipconfig /flushdns

pause
:SOFTEXIT
EXIT /B 0

:FAILUREMODE
pause
EXIT /B 1




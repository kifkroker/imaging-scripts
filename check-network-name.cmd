@echo off

SET SLEEP="C:\SysUtils\sleep_seconds.exe"
SET VERIFY-PERMISSIONS-SCRIPT="C:\SysUtils\Scripts\Verify-Administrator-Privileges.cmd"
SET VERIFY-NETWORK-IS-ACTIVE-SCRIPT="C:\SysUtils\Scripts\wait-on-networking-with-timeout.cmd"


echo ...................................................................
echo .                                                                 .
echo .                       Check Network Name                        .
echo .         This script will show the current name of the           .
echo .    network connection.  It will be listed under "NAME": in      .
echo .                       LAN interface                             .
echo .                                                                 .
echo .      If the name is not "Ethernet" you must change it in        .
echo .    Internet Options.  This is a requirement for the KIX IPv4    .
echo .       address configurations to work.  If it is something       .
echo .      else, KIX will *NOT* change the IP to the correct one       .
echo .                                                                 .
echo .    If there is a number after Ethernet, you must remove it!     .
echo .                                                                 .
echo ...................................................................
pause
:: .
:: This script requires admin privileges
:: 

CALL %VERIFY-PERMISSIONS-SCRIPT%
if %errorLevel% NEQ 0 (
   echo.
   echo This rquires administative permissions to run.
   echo.
   goto :FAILUREMODE  )

CALL %VERIFY-NETWORK-IS-ACTIVE-SCRIPT%
if %errorLevel% NEQ 0 ( 
   echo.
   echo Networking is down. Try again later.
   echo.
   goto :FAILUREMODE  )

net start dot3svc
CLS
netsh lan show interfaces
echo.
echo Press ctrl/C to abort this script or Return to finish with rename and reboot
pause
:SOFTEXIT
EXIT /B 0

:FAILUREMODE
EXIT /B 1



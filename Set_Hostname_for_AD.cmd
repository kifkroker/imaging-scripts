@echo off
cls

SET SLEEP="C:\SysUtils\sleep_seconds.exe"
SET VERIFY-PERMISSIONS-SCRIPT="C:\SysUtils\Scripts\Verify-Administrator-Privileges.cmd"
SET VERIFY-NETWORK-IS-ACTIVE-SCRIPT="C:\SysUtils\Scripts\wait-on-networking-with-timeout.cmd"

SET SOLIDWORKS-FOLDER="C:\Program Files\SOLIDWORKS Corp"

:: .
:: This script requires admin privileges
:: 
:: SUDO cannot be used since Deep Freeze with Win 11 now breaks
:: sudo commands after the image is frozen.  We have to assume
:: that the script is called with admin privileges either from
:: a shortcut off the desktop *OR* from the startup-task script
:: started from the task scheduler
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

net start w32time
w32tm /resync

echo.
echo.
echo.
echo Changing Hostname on Computer
echo.
echo.
C:\Sysutils\wsname /REBOOT /N:P-$MAC /EXCLUDEADAPTERS[WIRELESS WLAN BLUETOOTH PPP VMWARE IPSEC TUNNEL VIRTUALBOX]
:SOFTEXIT
EXIT /B 0

:FAILUREMODE
pause
EXIT /B 1



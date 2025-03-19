@echo off
cls

SET SLEEP="C:\SysUtils\sleep_seconds.exe"
SET VERIFY-PERMISSIONS-SCRIPT="C:\SysUtils\Scripts\Verify-Administrator-Privileges.cmd"

:: .
:: This script requires admin privileges
:: .

CALL %VERIFY-PERMISSIONS-SCRIPT%
if %errorLevel% NEQ 0 ( goto :FAILUREMODE  )

echo.
echo.
echo ...................................................................
echo .                                                                 .
echo .                  For NTFS file systems only                     .
echo .                                                                 .
echo .         This script will set the dirty bit on drive C:          .
echo .            so it will force a chkdsk on next reboot.            .
echo .                                                                 .
echo .              This requires a reboot to take effect.             .
echo .                                                                 .
echo ...................................................................
echo.
echo.
echo       Press ctrl/C to abort this script or Return to proceed
echo.
pause

fsutil dirty set c:

pause
:SOFTEXIT
EXIT /B 0

:FAILUREMODE
pause
EXIT /B 1

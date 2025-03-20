@echo off
cls

SET SLEEP="C:\SysUtils\sleep_seconds.exe"
SET VERIFY-PERMISSIONS-SCRIPT="C:\SysUtils\Scripts\Verify-Administrator-Privileges.cmd"

CALL %VERIFY-PERMISSIONS-SCRIPT%
if %errorLevel% NEQ 0 ( goto :FAILUREMODE  )

echo ...................................................................
echo .                    sw-agree v 1.4 03-20-2025                    .
echo .                                                                 .
echo .    This script will agree to Solidworks license terms in the    .
echo .    registry to prevent annoying popups every time the hostname  .
echo .    changes.                                                     .
echo .                                                                 .
echo ...................................................................
echo .
echo .
echo .

powershell -ExecutionPolicy Unrestricted -File C:\SysUtils\PowerShell\sw_agree.ps1
C:\SysUtils\Sync64.exe /accepteula

%SLEEP% 3

echo.
echo.
echo. | set /p="----------------------------"
echo.
echo License agreement completed.
EXIT /B 0
EXIT /B 0
EXIT
goto :SOFTEXIT

:FAILUREMODE
echo.
echo.
echo ------------------------------
echo ERROR #5 - No Admin Privileges
echo.
%SLEEP% 5

:SOFTEXIT
EXIT /B 1
EXIT /B 1
EXIT

@echo off
cls

SET OFFICECURRENT="C:\program files (x86)\microsoft office\office16\ospp.vbs"

SET WINACTIVATE="C:\windows\system32\slmgr.vbs"

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
if %errorLevel% NEQ 0 ( goto :FAILUREMODE  )

:: put a flag out to show we have started the activation procedure

if not exist "C:\WinApps\" ( 
     mkdir C:\WinApps
) ELSE (
	 DEL /f C:\WinApps\canary.txt
	 DEL /f C:\WinApps\canary-died.txt
	 )
echo "I live" >> C:\WinApps\canary.txt

echo ...................................................................
echo .                                                                 .
echo .          This script will activate Windows and Office           .
echo .          And acknowledge the Solidworks License                 .
echo .                                                                 .
echo .                                                                 .
echo .                       Ver 2.01 03-20-2025                       .
echo .                                                                 .
echo .                                                                 .
echo .   Giving Windows a few moments to settle down and flush cache   .
echo .                                                                 .
echo ...................................................................
echo.
echo.

C:\SysUtils\Sync64.exe /accepteula

%SLEEP% 3

CALL %VERIFY-NETWORK-IS-ACTIVE-SCRIPT%
if %errorLevel% NEQ 0 ( goto :FAILUREMODE  )


net start w32time
w32tm /resync
:: %SLEEP% 2
:: cls
if not exist %WINACTIVATE% (
     echo ...................................................................
     echo .                                                                 .
     echo .                                                                 .
     echo .     ERROR: Microsoft Windows Activation Utility Not Found       .
     echo .                                                                 .
     echo .                                                                 .
     echo ...................................................................
     echo.
     echo.
     goto :FAILUREMODE )
echo.
echo.
echo -------------------------------
echo ---[ Activating MS Windows ]---
echo -------------------------------
echo.
echo.
cscript %WINACTIVATE% -ato
if %ERRORLEVEL% NEQ 0 (
     echo ...................................................................
     echo .                                                                 .
     echo .                                                                 .
     echo .                    Windows Activation Failed!                    .
     echo .                                                                 .
     echo .                                                                 .
     echo ...................................................................
     echo.
     echo.
     goto :FAILUREMODE )
echo ...................................................................
echo .                                                                 .
echo .                                                                 .
echo .                   Windows Activation Succeeded                  .
echo .                                                                 .
echo .                                                                 .
echo ...................................................................
echo.
echo.

::cls

if not exist %OFFICECURRENT% (
     echo ...................................................................
     echo .                                                                 .
     echo .                                                                 .
     echo .      ERROR: Microsoft Office Activation Utility Not Found       .
     echo .                                                                 .
     echo .                                                                 .
     echo ...................................................................
     echo.
     echo.
     goto :FAILUREMODE )
echo.
echo.
echo ------------------------------
echo ---[ Activating MS Office ]---
echo ------------------------------
echo.
echo.
cscript %OFFICECURRENT% /act
if %ERRORLEVEL% NEQ 0 (
     echo ...................................................................
     echo .                                                                 .
     echo .                                                                 .
     echo .                    Office Activation Failed!                    .
     echo .                                                                 .
     echo .                                                                 .
     echo ...................................................................
     echo.
     echo.
     goto :FAILUREMODE )
echo ...................................................................
echo .                                                                 .
echo .                                                                 .
echo .                   Office Activation Succeeded                   .
echo .                                                                 .
echo .                                                                 .
echo ...................................................................
echo.
echo.
DEL /f C:\WinApps\canary.txt
DEL /f C:\WinApps\canary-died.txt
C:\SysUtils\Sync64.exe /accepteula
if exist %SOLIDWORKS-FOLDER% (
     echo ...................................................................
     echo .                                                                 .
     echo .                                                                 .
     echo .               --- FOUND SOLIDWORKS INSTALLED ---                .
     echo .                                                                 .
     echo .                                                                 .
     echo ...................................................................
     echo.
     echo.
     powershell -ExecutionPolicy Unrestricted -File C:\SysUtils\PowerShell\sw_agree.ps1
     %SLEEP% 1
     C:\SysUtils\Sync64.exe /accepteula
) ELSE (
     echo.
     echo.
	 echo Solidworks is not installed on this image.
	 echo.
     echo.
	 )

%SLEEP% 5
CLS
CLS
echo.
echo.
echo. | set /p="------------------------------"
echo.
echo All Activations have completed.
EXIT /B 0
EXIT /B 0
EXIT
goto :SOFTEXIT

:FAILUREMODE

if not exist C:\WinApps\canary.txt (
     echo ERROR #5 - No Admin Privileges
	 EXIT /B 5
) ELSE (
     DEL /f C:\WinApps\canary.txt
	 echo "I kicked the bucket.  :-(" >> C:\WinApps\canary-died.txt
	 echo ERROR #1 - Failed Activation
	 echo.
	 echo.
	 echo.
)
%SLEEP% 5

:SOFTEXIT
EXIT /B 1
EXIT /B 1
EXIT

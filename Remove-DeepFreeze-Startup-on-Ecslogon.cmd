@echo off

::
:: This script removes the DeepFreeze shortcut that runs on the next
:: ecslogon log in
::
:: Ver 1.1
::
:: first updated 7-28-2022
:: Last updated 03-20-2025

SET SLEEP="C:\SysUtils\sleep_seconds.exe"
SET DEEPFREEZE-LINK="C:\Users\ecslogon\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\Run DeepFreeze.lnk"
SET VERIFY-PERMISSIONS-SCRIPT="C:\SysUtils\Scripts\Verify-Administrator-Privileges.cmd"

echo ...................................................................
echo .                                                                 .
echo .    This script will DELETE a shortcut to the Run Deepfreeze     .
echo .    script in the ECSLOGON user startup folder                   .
echo .                                                                 .
echo ...................................................................

CALL %VERIFY-PERMISSIONS-SCRIPT%
if %errorLevel% NEQ 0 ( goto :FAILUREMODE  )

If exist %DEEPFREEZE-LINK% (
    echo 'Found startup shortcut.  Deleting...'
	DEL /F %DEEPFREEZE-LINK%  
) ELSE (
    echo.
    echo -----------------------------------
    echo No DeepFreeze shortcut was found...
    echo -----------------------------------
    echo.
	EXIT /B 0)

If exist %DEEPFREEZE-LINK% (
    echo Deepfreeze shortcut was not removed.
    goto :FAILUREMODE
) ELSE (
    echo.
    echo ---------------------------------------------
    echo Deepfreeze shortcut was successfully removed.
    echo ---------------------------------------------
    echo.
)


echo ...................................................................
echo .  DeepFreeze installer will NOT run for ECSLOGON at next login   .
echo ...................................................................
echo.

%SLEEP% 1

:SOFTEXIT
EXIT /B 0

:FAILUREMODE
echo ....................................................................
echo .                                                                  .
echo .   DeepFreeze removal script FAILED to remove ECSLOGON startup    .
echo .                                                                  .
echo ....................................................................
pause
EXIT /B 1

@echo off

SET SLEEP="C:\SysUtils\sleep_seconds.exe"
SET DEEPFREEZE-STARTUP="C:\SysUtils\Shortcuts\Run DeepFreeze.lnk"
SET DEEPFREEZE-DEST-STARTUP="C:\Users\ecslogon\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\"
SET DEEPFREEZE-LINK="C:\Users\ecslogon\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\Run DeepFreeze.lnk"

SET VERIFY-PERMISSIONS-SCRIPT="C:\SysUtils\Scripts\Verify-Administrator-Privileges.cmd"

echo ...................................................................
echo .                                                                 .
echo .    This script will create a shortcut to the Run Deepfreeze     .
echo .    script in the ECSLOGON user startup folder to run on the     .
echo .    next login.                                                  .
echo .                                                                 .
echo ...................................................................

If exist %DEEPFREEZE-LINK% (
    echo.
    echo -------------------------------------------------------------
    echo Deepfreeze shortcut is already configured to run on ECSLOGON.  
    echo -------------------------------------------------------------
    echo.
	goto SOFTEXIT )

CALL %VERIFY-PERMISSIONS-SCRIPT%
if %errorLevel% NEQ 0 ( goto :FAILUREMODE  )

COPY /y /v %DEEPFREEZE-STARTUP% %DEEPFREEZE-DEST-STARTUP%
if %errorLevel% NEQ 0 ( goto :FAILUREMODE  )

If exist %DEEPFREEZE-LINK% (
    echo.
    echo -----------------------------------------------
    echo Deepfreeze shortcut was successfully installed.  
    echo -----------------------------------------------
    echo.
) ELSE (
    echo Deepfreeze shortcut was *NOT* installed.
	goto :FAILUREMODE )

%SLEEP% 1

:SOFTEXIT
EXIT /B 0

:FAILUREMODE
echo.
echo.
echo ....................................................................
echo .                                                                  .
echo . DeepFreeze installer script FAILED to load into ECSLOGON startup .
echo .                                                                  .
echo ....................................................................
pause
EXIT /B 1

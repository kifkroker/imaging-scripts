@echo off

SET SLEEP="C:\SysUtils\sleep_seconds.exe"

SET SETUP-WALLPAPER="C:\SysUtils\Scripts\Set_Wallpaper_stage1.cmd"
SET CHANGE-SIGNON-WALLPAPER-RED="C:\SysUtils\Scripts\Set_Login_Wallpaper_In_Progress.cmd"

SET VERIFY-PERMISSIONS-SCRIPT="C:\SysUtils\Scripts\Verify-Administrator-Privileges.cmd"
SET LOOK-FOR-PGINA="C:\SysUtils\Scripts\is-pgina-installed.cmd"
SET RENAME-HOST="C:\SysUtils\Scripts\Set_Hostname_By_DNS.cmd"
SET VERIFY-NETWORK-NAME="C:\SysUtils\Scripts\check-network-name.cmd"

CALL %VERIFY-PERMISSIONS-SCRIPT%
if %errorLevel% NEQ 0 ( goto :FAILUREMODE  )

CALL %LOOK-FOR-PGINA%
if %errorLevel% NEQ 0 ( 
   echo PGina is not installed
) ELSE (
   echo PGina is not installed
)

echo.
echo ....................................................................
echo .                                                                  .
echo .                  Version 3.0 03/20/2025                         .
echo .                                                                  .
echo .                                                                  .
echo .   This script prepares the image for deployment.  The hostname   .
echo .   will be changed and the wallpaper will be set for stage #1     .
echo .                                                                  .
echo .   This script no longer sets DEEPFREEZE to run in ecslogon       .
echo .   since other scripts set that startup                           .
echo .                                                                  .
echo .                                                                  .
echo ....................................................................
echo.
echo.
echo Press ctrl/C to abort this script or Return to proceed
pause
CALL %SETUP-WALLPAPER%
echo.
echo.
echo ....................................................................
echo .                                                                  .
echo .                                                                  .
echo .      Changing signon background to red in-progress wallpaper     .
echo .                                                                  .
echo .                                                                  .
echo ....................................................................
echo.
echo.
CALL %CHANGE-SIGNON-WALLPAPER-RED%
CALL %VERIFY-NETWORK-NAME%
if %errorLevel% NEQ 0 ( goto :FAILUREMODE  )
echo.
echo.
echo ....................................................................
echo .                                                                  .
echo .                                                                  .
echo .   Make sure ECSROOT password is SET and autologins are enabled   .
echo .                                                                  .
echo .                                                                  .
echo .    The Next step is to change the hostname to CHANGEME-XXXX      .
echo .      After the reboot make sure you clear the networking         .
echo .                                                                  .
echo .                                                                  .
echo ....................................................................
echo.
echo.
echo Press ctrl/C to abort this script or Return to finish with rename and reboot
pause
CALL %RENAME-HOST%
if %errorLevel% NEQ 0 ( goto :FAILUREMODE  )
C:\SysUtils\Sync64.exe /accepteula
echo ....................................................................
echo .                                                                  .
echo .                  No Failures.  Youre good to go                  .
echo .                                                                  .
echo ....................................................................
%SLEEP% 10

:SOFTEXIT
EXIT /B 0

:FAILUREMODE
echo.
echo ---[Hit RETURN to Exit]---
pause
EXIT /B 1








@echo off
echo.
echo ...................................................................
echo .                                                                 .
echo .     Setting sign-in background to standard ecslogon prompt      .
echo .                                                                 .
echo ...................................................................
pushd .
C:
CD \SysUtils\WallPaper
COPY /V /Y C:\SysUtils\WallPaper\ecs_logon_background_1680x1050.jpg C:\Sysutils\WallPaper\ecs_current_signon.jpg
popd .

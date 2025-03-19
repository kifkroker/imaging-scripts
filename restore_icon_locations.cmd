@echo off
cls
SET SLEEP="C:\SysUtils\sleep_seconds.exe"
SET RECOVER_ICONS="c:\Program Files\Iconoid\iconoid64.exe"

echo ...................................................................
echo .                                                                 .
echo .          This script will restore funky icon locations          .
echo .                                                                 .
echo .                                                                 .
echo .                       Ver 1.1 4-02-2020                         .
echo .                                                                 .
echo .                                                                 .
echo .   Giving Windows a few moments to settle down and flush cache   .
echo .   Desktop refresh or early login can affect icon positions.     .
echo .                                                                 .
echo ...................................................................
echo.
echo.
%SLEEP% 12
%RECOVER_ICONS% -restore
echo ...................................................................
echo .                                                                 .
echo .                   Icon positions are restored                   .
echo .                                                                 .
echo ...................................................................
echo.

@echo off
echo ...................................................................
echo .                                                                 .
echo .                  Wait-On-Networking Ver 1.01                    .
echo .                    Last updated 03-20-2025                      .
echo .                                                                 .
echo .       This script will wait until the network responds          .
echo .    by trying to get the root webpage from the WEB-HOST www      .
echo .       server.  It will loop until the server responds.          .
echo .    This script is written for Window 11 and built-in curl.      .
echo .                                                                 .
echo ...................................................................
echo.

SET WEB-HOST="web1.cs.wright.edu"
SET SLEEP="C:\SysUtils\sleep_seconds.exe"
SET /A MYCOUNT=1

echo.
echo.
:WAIT4NET
echo.
echo Attempt #%MYCOUNT%   [Checking to see if network is active.]
echo.
curl %WEB-HOST% > NUL
if %ERRORLEVEL% NEQ 0 (
   SET /A MYCOUNT+=1
   echo ...................................................................
   echo .                                                                 .
   echo .        Network is not stable yet.    Can't find www host        .
   echo .                                                                 .
   echo .                                                                 .
   echo .             Waiting a few seconds before trying again           .
   echo .                                                                 .
   echo ...................................................................
   echo.
   echo Press ctrl/C to abort this script
   echo.
   %SLEEP% 3
   cls
   goto :WAIT4NET )
echo Host %WEB-HOST% is now responding.
echo.
echo.
echo ...................................................................
echo .                                                                 .
echo .                      Network is now up.                         .
echo .                                                                 .
echo ...................................................................
echo.
echo.
EXIT /B 0
EXIT /B 0

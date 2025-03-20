@echo off
echo ...................................................................
echo .                                                                 .
echo .                  Wait-On-Networking Ver 1.00                    .
echo .                      Now with TIMEOUT!!!                        .
echo .                    Last updated 03-20-2025                      .
echo .                                                                 .
echo .       This script will wait until the network responds          .
echo .    by trying to get the root webpage from the WEB-HOST www      .
echo .       server.  It will loop until the server responds.          .
echo .    This script is written for Window 11 and built-in curl.      .
echo .      This will try 10 times to find the webserver before        .
echo .                    giving up and failing                        .
echo .                                                                 .
echo .                                                                 .
echo ...................................................................
echo.

SET WEB-HOST="web1.cs.wright.edu"
SET SLEEP="C:\SysUtils\sleep_seconds.exe"
SET /A TIMEOUTS=10
SET /A MYCOUNT=1

:WAIT4NET
echo.
echo.
echo.
echo Attempt #%MYCOUNT%   [Checking to see if network is active.]
echo.
curl %WEB-HOST% > NUL
IF %ERRORLEVEL% NEQ 0 (
  SET /A MYCOUNT+=1
  IF "%MYCOUNT%" NEQ "%TIMEOUTS%" (
     echo ...................................................................
     echo .                                                                 .
     echo .       Network is not stable yet.    Can't find web host         .
     echo .                                                                 .
     echo .                                                                 .
     echo .             Waiting a few seconds before trying again           .
     echo .                                                                 .
     echo ...................................................................
     echo.
     echo.
     echo Press ctrl/C to abort this script	 )
  IF "%MYCOUNT%" == "%TIMEOUTS%" (
     echo ...................................................................
     echo .                                                                 .
     echo .       Network did not respond in allotted time.  Network        .
     echo .             Failure.  Quitting activation effort                .
     echo .                                                                 .
     echo ...................................................................
     echo.
     echo.
     GOTO :FAILUREMODE )
echo.
%SLEEP% 3
cls
goto :WAIT4NET )
echo.
echo Host %WEB-HOST% is now responding.
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
EXIT
goto :BYPASS

:FAILUREMODE
:BYPASS

EXIT /B 1
EXIT /B 1
EXIT

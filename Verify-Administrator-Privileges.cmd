@echo off
:: 
:: This script verifies admin privileges
:: updated 03-20-2025

echo ...................................................................
echo .              Verifying Administrative Permissions               .
echo ...................................................................

net session >nul 2>&1
if %errorLevel% == 0 (
   echo Administrative permissions confirmed.
   echo.
   EXIT /B 0 )

echo ...................................................................
echo .                                                                 .
echo .         FAILED: Restart this script as Administrator            .
echo .                                                                 .
echo .                         and try again                           .
echo .                                                                 .
echo ...................................................................
EXIT /B 1


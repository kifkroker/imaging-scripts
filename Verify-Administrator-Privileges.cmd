@echo off
:: .
:: This script verifies admin privileges
:: .

:check_Permissions

echo ...................................................................
echo .                                                                 .
echo .              Verifying Administrative Permissions               .
echo .                                                                 .
echo ...................................................................

net session >nul 2>&1
if %errorLevel% == 0 (
   echo .
   echo Administrative permissions confirmed.
   echo .
   EXIT /B 0 )

echo ...................................................................
echo .                                                                 .
echo .                                                                 .
echo .         Failed: Restart this script as Administrator            .
echo .                                                                 .
echo .     Press Return to exit and try it again after corrections     .
echo .                                                                 .
echo .                                                                 .
echo ...................................................................

:FAILUREMODE
EXIT /B 1


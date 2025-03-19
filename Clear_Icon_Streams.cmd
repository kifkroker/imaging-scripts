@echo off

SET SLEEP="C:\SysUtils\sleep_seconds.exe"

:: Clear-Icon-Streams
:: Version: 1.01
:: Release Date: 03-19-2025


:: We are using gsudo since the script is never called within a frozen
:: image so we do not need to verift admin privileges anymore.
:: SET VERIFY-PERMISSIONS-SCRIPT="C:\SysUtils\Scripts\Verify-Administrator-Privileges.cmd"
::
:: This may be a Windows 10 thing only.  Windows 11 does tray icons differently.

echo ...................................................................
echo .                                                                 .
echo .    This script will create remove the iconstreams values        .
echo .    from the registry fixing the missing icons in the tray       .
echo .    problem.                                                  .
echo .                                                                 .
echo ...................................................................

pushd .
C:
CD \Sysutils\PowerShell
CD
gsudo powershell -ExecutionPolicy Unrestricted -File clear_icon_streams.ps1
popd


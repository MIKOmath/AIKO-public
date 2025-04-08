@echo off
setlocal EnableDelayedExpansion

if "%~1"=="" (
    echo Usage: %~nx0 password
    echo Example: %~nx0 mypassword
    exit /b 1
)

set "PASSWORD=%~1"
set COUNT=0
set FAILED=0

echo Starting to unpack all zip files using provided password...

for %%F in (*.zip) do (
    if exist "%%F" (
        echo Unpacking: %%F
        
        7z x -p"%PASSWORD%" "%%F" >nul 2>&1
        
        if !errorlevel! equ 0 (
            echo Successfully unpacked: %%F
            set /a COUNT+=1
        ) else (
            echo Failed to unpack: %%F (possibly wrong password or corrupted file^)
            set /a FAILED+=1
        )
    )
)

if %COUNT%==0 if %FAILED%==0 (
    echo No zip files found in the current directory.
    exit /b 0
)

echo.
echo Unpacking complete.
echo %COUNT% files successfully unpacked.
if %FAILED% gtr 0 (
    echo %FAILED% files failed to unpack.
)

endlocal
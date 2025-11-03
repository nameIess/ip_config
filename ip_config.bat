@echo off
setlocal enabledelayedexpansion
title IP Configuration Utility
color 0A
title Network Profile Configuration Tool

:: Check for Administrator privileges and auto-elevate if needed
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting Administrator privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:MENU
cls
echo ============================================
echo    Network Profile Configuration Tool
echo ============================================
echo.
echo Detecting available network adapters...
echo.

:: Create a temporary file to store adapter names
set "tempFile=%temp%\netadapters_%random%.txt"
powershell -Command "Get-NetAdapter | Where-Object {$_.Status -ne 'Disabled'} | ForEach-Object {$_.Name}" > "%tempFile%"

:: Read adapter names from temp file
set count=0
for /f "usebackq delims=" %%a in ("%tempFile%") do (
    set /a count+=1
    set "adapter!count!=%%a"
    echo [!count!] %%a
)

:: Clean up temp file
del "%tempFile%" 2>nul

if %count%==0 (
    color 0C
    echo No network adapters found!
    echo.
    pause
    exit /b 1
)

echo.
echo ============================================
set /p selection="Select adapter number (1-%count%): "

:: Validate selection
if "!selection!"=="" goto INVALID
if !selection! lss 1 goto INVALID
if !selection! gtr %count% goto INVALID

:: Get the selected adapter name using delayed expansion
if "!selection!"=="1" set "selectedAdapter=!adapter1!"
if "!selection!"=="2" set "selectedAdapter=!adapter2!"
if "!selection!"=="3" set "selectedAdapter=!adapter3!"
if "!selection!"=="4" set "selectedAdapter=!adapter4!"
if "!selection!"=="5" set "selectedAdapter=!adapter5!"
if "!selection!"=="6" set "selectedAdapter=!adapter6!"
if "!selection!"=="7" set "selectedAdapter=!adapter7!"
if "!selection!"=="8" set "selectedAdapter=!adapter8!"
if "!selection!"=="9" set "selectedAdapter=!adapter9!"
if "!selection!"=="10" set "selectedAdapter=!adapter10!"
echo.
echo Selected Adapter: !selectedAdapter!
echo.

:PROFILE_MENU
echo ============================================
echo     Choose Configuration Profile
echo ============================================
echo.
echo [1] PC 1 Profile
echo     - IP: 192.168.0.1
echo     - Gateway: 192.168.0.2
echo.
echo [2] PC 2 Profile
echo     - IP: 192.168.0.2
echo     - Gateway: 192.168.0.1
echo.
echo [3] Reset to Default (DHCP)
echo.
echo [4] Return to Adapter Selection
echo.
echo ============================================
set /p profile="Select profile (1-4): "

if "%profile%"=="1" goto PC1
if "%profile%"=="2" goto PC2
if "%profile%"=="3" goto RESET
if "%profile%"=="4" goto MENU
goto INVALID_PROFILE

:PC1
cls
echo ============================================
echo       Setting Up PC 1 Profile
echo ============================================
echo.
echo Adapter: !selectedAdapter!
echo.
echo Configuring static IP address...
netsh interface ip set address name="!selectedAdapter!" static 192.168.0.1 255.255.255.0 192.168.0.2
if %errorLevel% equ 0 (
    echo [OK] IP Address set to 192.168.0.1
    echo [OK] Subnet Mask set to 255.255.255.0
    echo [OK] Gateway set to 192.168.0.2
) else (
    color 0C
    echo [ERROR] Failed to set IP configuration
)
echo.
echo Configuring DNS servers...
netsh interface ip set dns name="!selectedAdapter!" static 208.67.222.222
echo [OK] Primary DNS set to 208.67.222.222 (OpenDNS)

netsh interface ip add dns name="!selectedAdapter!" 208.67.220.220 index=2
echo [OK] Secondary DNS set to 208.67.220.220 (OpenDNS)
echo.
echo ============================================
echo   PC 1 Profile Configuration Complete!
echo ============================================
echo.
choice /c RN /n /m "Press R to return to menu, any other key to exit"
if %errorlevel% equ 1 goto PROFILE_MENU
goto END

:PC2
cls
echo ============================================
echo       Setting Up PC 2 Profile
echo ============================================
echo.
echo Adapter: !selectedAdapter!
echo.
echo Configuring static IP address...
netsh interface ip set address name="!selectedAdapter!" static 192.168.0.2 255.255.255.0 192.168.0.1
if %errorLevel% equ 0 (
    echo [OK] IP Address set to 192.168.0.2
    echo [OK] Subnet Mask set to 255.255.255.0
    echo [OK] Gateway set to 192.168.0.1
) else (
    color 0C
    echo [ERROR] Failed to set IP configuration
)
echo.
echo Configuring DNS servers...
netsh interface ip set dns name="!selectedAdapter!" static 208.67.222.222
echo [OK] Primary DNS set to 208.67.222.222 (OpenDNS)

netsh interface ip add dns name="!selectedAdapter!" 208.67.220.220 index=2
echo [OK] Secondary DNS set to 208.67.220.220 (OpenDNS)
echo.
echo ============================================
echo   PC 2 Profile Configuration Complete!
echo ============================================
echo.
choice /c RN /n /m "Press R to return to menu, any other key to exit"
if %errorlevel% equ 1 goto PROFILE_MENU
goto END

:RESET
cls
echo ============================================
echo      Resetting to Default Settings
echo ============================================
echo.
echo Adapter: !selectedAdapter!
echo.
set "escapedAdapter=!selectedAdapter:'=''!"
set "logFile=%temp%\ipreset_%random%.log"
echo Obtaining IP address automatically... > "%logFile%"
netsh interface ip set address name="!selectedAdapter!" source=dhcp >>"%logFile%" 2>&1
if %errorLevel% equ 0 (
    echo [OK] IP address set to obtain automatically (DHCP)
) else (
    echo Trying PowerShell fallback to enable DHCP...
    powershell -Command "$adapter = '!escapedAdapter!'; Try { Set-NetIPInterface -InterfaceAlias $adapter -Dhcp Enabled; Write-Output 'PS: DHCP enabled' } Catch { Write-Error $_.Exception.Message; exit 1 }" >>"%logFile%" 2>&1
    if %errorLevel% equ 0 (
        echo [OK] IP address set to obtain automatically (DHCP)
    ) else (
        color 0C
        echo [ERROR] Failed to set IP configuration to DHCP
        echo --- output ---
        type "%logFile%"
        echo ---------------------
    )
)
echo.
echo Setting DNS servers to obtain automatically... >> "%logFile%"
netsh interface ip set dns name="!selectedAdapter!" source=dhcp >>"%logFile%" 2>&1
if %errorLevel% equ 0 (
    echo [OK] DNS servers set to obtain automatically (DHCP)
) else (
    echo Trying PowerShell fallback to reset DNS servers...
    powershell -Command "$adapter = '!escapedAdapter!'; Try { Set-DnsClientServerAddress -InterfaceAlias $adapter -ResetServerAddresses; Write-Output 'PS: DNS reset' } Catch { Write-Error $_.Exception.Message; exit 1 }" >>"%logFile%" 2>&1
    if %errorLevel% equ 0 (
        echo [OK] DNS servers set to obtain automatically (DHCP)
    ) else (
        color 0C
        echo [ERROR] Failed to set DNS to DHCP
        echo --- output ---
        type "%logFile%"
        echo ---------------------
    )
)

echo.
echo Current adapter configuration:
netsh interface ip show config name="!selectedAdapter!"
echo.
echo Attempting to remove leftover default gateway routes (if any)... >> "%logFile%"
powershell -Command "$adapter = '!escapedAdapter!'; Try { $r = Get-NetRoute -DestinationPrefix '0.0.0.0/0' -ErrorAction SilentlyContinue | Where-Object { $_.InterfaceAlias -eq $adapter }; if ($r) { $r | ForEach-Object { Remove-NetRoute -DestinationPrefix $_.DestinationPrefix -NextHop $_.NextHop -InterfaceIndex $_.InterfaceIndex -Confirm:$false -ErrorAction Stop }; Write-Output \"PS: Removed default gateway route(s) for $adapter\" } else { Write-Output \"PS: No default gateway routes found for $adapter\" } } Catch { Write-Error $_.Exception.Message; exit 1 }" >>"%logFile%" 2>&1
echo.
echo Adapter configuration after route removal attempt:
netsh interface ip show config name="!selectedAdapter!"
echo.
del "%logFile%" 2>nul
echo.
echo ============================================
echo    Reset to Default Settings Complete!
echo ============================================
goto END

:INVALID
color 0C
echo.
echo Invalid selection! Please choose a number between 1 and %count%.
echo.
pause
goto MENU

:INVALID_PROFILE
color 0C
echo.
echo Invalid profile selection! Please choose 1, 2, 3, or 4.
echo.
pause
goto PROFILE_MENU

:END
echo.
echo.
echo Press any key to exit...
pause >nul
exit /b 0
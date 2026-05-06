@echo off
chcp 65001 >nul
echo ========================================
echo   Free Claude Code Installer
echo ========================================
echo.
echo This installer will set up everything
echo you need to run Claude Code for FREE
echo using NVIDIA NIM.
echo.
echo Press any key to continue...
pause >nul

:: Check if running as administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo WARNING: This installer requires administrator permissions.
    echo Please run this file as administrator.
    echo.
    echo Press any key to try to continue anyway...
    pause >nul
)

:: Run PowerShell script
echo.
echo Starting graphical installer...
echo.

powershell -ExecutionPolicy Bypass -File "%~dp0Installer-FreeClaudeCode.ps1"

if %errorLevel% neq 0 (
    echo.
    echo ERROR: Could not run the installer.
    echo Make sure the file Installer-FreeClaudeCode.ps1
    echo is in the same folder as this file.
    echo.
    pause
    exit /b 1
)

echo.
echo Installer finished.
pause

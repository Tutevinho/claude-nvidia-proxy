@echo off
chcp 65001 >nul
echo ========================================
echo   Free Claude Code Uninstaller
echo ========================================
echo.
echo This uninstaller will remove
echo Free Claude Code and all its files.
echo.
echo WARNING: This action cannot be undone.
echo.
echo Press any key to continue...
pause >nul

:: Check if running as administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo WARNING: This uninstaller requires administrator permissions.
    echo Please run this file as administrator.
    echo.
    echo Press any key to try to continue anyway...
    pause >nul
)

:: Run PowerShell script
echo.
echo Starting graphical uninstaller...
echo.

powershell -ExecutionPolicy Bypass -File "%~dp0Uninstaller-FreeClaudeCode.ps1"

if %errorLevel% neq 0 (
    echo.
    echo ERROR: Could not run the uninstaller.
    echo Make sure the file Uninstaller-FreeClaudeCode.ps1
    echo is in the same folder as this file.
    echo.
    pause
    exit /b 1
)

echo.
echo Uninstaller finished.
pause

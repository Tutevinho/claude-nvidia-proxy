# OpenCode CLI Graphical Installer for Windows 11
# Complete installation with graphical interface using Google Gemini API

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create main form
$form = New-Object System.Windows.Forms.Form
$form.Text = "OpenCode CLI Installer"
$form.Size = New-Object System.Drawing.Size(650, 550)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false
$form.BackColor = [System.Drawing.Color]::FromArgb(240, 240, 240)

# Title
$titleLabel = New-Object System.Windows.Forms.Label
$titleLabel.Text = "OpenCode CLI - Installer"
$titleLabel.Font = New-Object System.Drawing.Font("Segoe UI", 18, [System.Drawing.FontStyle]::Bold)
$titleLabel.Location = New-Object System.Drawing.Point(20, 20)
$titleLabel.Size = New-Object System.Drawing.Size(610, 40)
$titleLabel.TextAlign = "MiddleCenter"
$titleLabel.ForeColor = [System.Drawing.Color]::FromArgb(66, 133, 244) # Google Blue
$form.Controls.Add($titleLabel)

# Description
$descLabel = New-Object System.Windows.Forms.Label
$descLabel.Text = "This installer will set up everything you need to run OpenCode CLI using Google Gemini API."
$descLabel.Location = New-Object System.Drawing.Point(20, 70)
$descLabel.Size = New-Object System.Drawing.Size(610, 30)
$descLabel.TextAlign = "MiddleCenter"
$descLabel.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$form.Controls.Add($descLabel)

# Progress panel
$progressPanel = New-Object System.Windows.Forms.Panel
$progressPanel.Location = New-Object System.Drawing.Point(20, 120)
$progressPanel.Size = New-Object System.Drawing.Size(590, 220)
$progressPanel.BorderStyle = "FixedSingle"
$progressPanel.BackColor = [System.Drawing.Color]::White
$form.Controls.Add($progressPanel)

# Progress log
$logTextBox = New-Object System.Windows.Forms.TextBox
$logTextBox.Multiline = $true
$logTextBox.ScrollBars = "Vertical"
$logTextBox.ReadOnly = $true
$logTextBox.Location = New-Object System.Drawing.Point(5, 5)
$logTextBox.Size = New-Object System.Drawing.Size(580, 210)
$logTextBox.Font = New-Object System.Drawing.Font("Consolas", 9)
$logTextBox.BackColor = [System.Drawing.Color]::FromArgb(250, 250, 250)
$progressPanel.Controls.Add($logTextBox)

# Progress bar
$progressBar = New-Object System.Windows.Forms.ProgressBar
$progressBar.Location = New-Object System.Drawing.Point(20, 350)
$progressBar.Size = New-Object System.Drawing.Size(590, 25)
$progressBar.Style = "Continuous"
$form.Controls.Add($progressBar)

# Status label
$statusLabel = New-Object System.Windows.Forms.Label
$statusLabel.Text = "Ready to begin"
$statusLabel.Location = New-Object System.Drawing.Point(20, 380)
$statusLabel.Size = New-Object System.Drawing.Size(590, 20)
$statusLabel.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$form.Controls.Add($statusLabel)

# Install button
$installButton = New-Object System.Windows.Forms.Button
$installButton.Text = "Begin Installation"
$installButton.Location = New-Object System.Drawing.Point(20, 420)
$installButton.Size = New-Object System.Drawing.Size(590, 50)
$installButton.Font = New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
$installButton.BackColor = [System.Drawing.Color]::FromArgb(66, 133, 244)
$installButton.ForeColor = [System.Drawing.Color]::White
$installButton.FlatStyle = "Flat"
$installButton.FlatAppearance.BorderSize = 0
$installButton.Cursor = [System.Windows.Forms.Cursors]::Hand
$form.Controls.Add($installButton)

function Write-Log {
    param([string]$message)
    $timestamp = Get-Date -Format "HH:mm:ss"
    $logTextBox.AppendText("[$timestamp] $message`r`n")
    $logTextBox.ScrollToCaret()
    $form.Refresh()
}

function Update-Progress {
    param([int]$value, [string]$status)
    $progressBar.Value = $value
    $statusLabel.Text = $status
    $form.Refresh()
}

function Test-Command {
    param([string]$command)
    try {
        $null = Get-Command $command -ErrorAction Stop
        return $true
    } catch {
        return $false
    }
}

function Download-File {
    param([string]$url, [string]$output)
    try {
        $webClient = New-Object System.Net.WebClient
        $webClient.DownloadFile($url, $output)
        return $true
    } catch {
        Write-Log "ERROR downloading: $_"
        return $false
    }
}

function Get-GoogleAPIKey {
    $keyForm = New-Object System.Windows.Forms.Form
    $keyForm.Text = "Google Gemini API Key"
    $keyForm.Size = New-Object System.Drawing.Size(550, 400)
    $keyForm.StartPosition = "CenterScreen"
    $keyForm.FormBorderStyle = "FixedDialog"
    $keyForm.MaximizeBox = $false
    $keyForm.BackColor = [System.Drawing.Color]::FromArgb(240, 240, 240)

    $infoLabel = New-Object System.Windows.Forms.Label
    $infoLabel.Text = "To get your FREE Google Gemini API Key:`r`n`r`n1. Go to: https://aistudio.google.com/app/apikey`r`n2. Sign in with your Google account`r`n3. Click 'Create API key' or copy your existing one`r`n4. Copy and paste the key below"
    $infoLabel.Location = New-Object System.Drawing.Point(20, 20)
    $infoLabel.Size = New-Object System.Drawing.Size(510, 140)
    $infoLabel.Font = New-Object System.Drawing.Font("Segoe UI", 9)
    $keyForm.Controls.Add($infoLabel)

    $keyLabel = New-Object System.Windows.Forms.Label
    $keyLabel.Text = "API Key:"
    $keyLabel.Location = New-Object System.Drawing.Point(20, 170)
    $keyLabel.Size = New-Object System.Drawing.Size(100, 20)
    $keyLabel.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)
    $keyForm.Controls.Add($keyLabel)

    $keyTextBox = New-Object System.Windows.Forms.TextBox
    $keyTextBox.Location = New-Object System.Drawing.Point(120, 170)
    $keyTextBox.Size = New-Object System.Drawing.Size(390, 25)
    $keyTextBox.Font = New-Object System.Drawing.Font("Consolas", 10)
    $keyForm.Controls.Add($keyTextBox)

    $linkLabel = New-Object System.Windows.Forms.LinkLabel
    $linkLabel.Text = "Open https://aistudio.google.com/app/apikey"
    $linkLabel.Location = New-Object System.Drawing.Point(20, 205)
    $linkLabel.Size = New-Object System.Drawing.Size(510, 20)
    $linkLabel.Font = New-Object System.Drawing.Font("Segoe UI", 9)
    $linkLabel.LinkColor = [System.Drawing.Color]::FromArgb(66, 133, 244)
    $linkLabel.Add_Click({
        Start-Process "https://aistudio.google.com/app/apikey"
    })
    $keyForm.Controls.Add($linkLabel)

    $noteLabel = New-Object System.Windows.Forms.Label
    $noteLabel.Text = "Note: The API Key is generally free within certain quotas for development."
    $noteLabel.Location = New-Object System.Drawing.Point(20, 235)
    $noteLabel.Size = New-Object System.Drawing.Size(510, 40)
    $noteLabel.Font = New-Object System.Drawing.Font("Segoe UI", 8)
    $noteLabel.ForeColor = [System.Drawing.Color]::FromArgb(100, 100, 100)
    $keyForm.Controls.Add($noteLabel)

    $okButton = New-Object System.Windows.Forms.Button
    $okButton.Text = "OK"
    $okButton.DialogResult = "OK"
    $okButton.Location = New-Object System.Drawing.Point(150, 290)
    $okButton.Size = New-Object System.Drawing.Size(100, 35)
    $okButton.Font = New-Object System.Drawing.Font("Segoe UI", 10)
    $okButton.BackColor = [System.Drawing.Color]::FromArgb(66, 133, 244)
    $okButton.ForeColor = [System.Drawing.Color]::White
    $okButton.FlatStyle = "Flat"
    $okButton.FlatAppearance.BorderSize = 0
    $keyForm.Controls.Add($okButton)

    $cancelButton = New-Object System.Windows.Forms.Button
    $cancelButton.Text = "Cancel"
    $cancelButton.DialogResult = "Cancel"
    $cancelButton.Location = New-Object System.Drawing.Point(270, 290)
    $cancelButton.Size = New-Object System.Drawing.Size(100, 35)
    $cancelButton.Font = New-Object System.Drawing.Font("Segoe UI", 10)
    $cancelButton.BackColor = [System.Drawing.Color]::FromArgb(100, 100, 100)
    $cancelButton.ForeColor = [System.Drawing.Color]::White
    $cancelButton.FlatStyle = "Flat"
    $cancelButton.FlatAppearance.BorderSize = 0
    $keyForm.Controls.Add($cancelButton)

    $result = $keyForm.ShowDialog()
    if ($result -eq "OK") {
        return $keyTextBox.Text.Trim()
    }
    return $null
}

function Cleanup-OnFailure {
    param([string]$reason)
    Write-Log "=========================================="
    Write-Log "INSTALLATION FAILED: $reason"
    Write-Log "Cleaning up..."
    Write-Log "=========================================="
    $installDir = "$env:USERPROFILE\opencode-gemini-proxy"
    $batFile = "$env:USERPROFILE\Desktop\OpenCodeCLI.bat"
    try {
        $processes = Get-NetTCPConnection -LocalPort 8082 -ErrorAction SilentlyContinue
        if ($processes) {
            foreach ($proc in $processes) {
                Stop-Process -Id $proc.OwningProcess -Force -ErrorAction SilentlyContinue
            }
        }
        if (Test-Path $installDir) {
            Remove-Item $installDir -Recurse -Force
        }
        if (Test-Path $batFile) {
            Remove-Item $batFile -Force
        }
    } catch { Write-Log "WARNING: Cleanup error: $_" }
    Write-Log "Cleanup completed."
}

function Get-UvPath {
    $uvPaths = @("$env:USERPROFILE\.cargo\bin\uv.exe", "$env:USERPROFILE\.local\bin\uv.exe", "$env:APPDATA\Python\Scripts\uv.exe", "$env:LOCALAPPDATA\Programs\Python\Python312\Scripts\uv.exe")
    foreach ($path in $uvPaths) { if (Test-Path $path) { return $path } }
    return $null
}

function Add-ToPath {
    param([string]$directory)
    if (-not (Test-Path $directory)) { return $false }
    try {
        $currentPath = [System.Environment]::GetEnvironmentVariable("Path", "User")
        if ($currentPath -notlike "*$directory*") {
            [System.Environment]::SetEnvironmentVariable("Path", "$directory;$currentPath", "User")
            return $true
        }
        return $true
    } catch { return $false }
}

function Refresh-Path {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

function Start-Installation {
    $installButton.Enabled = $false
    $installButton.Text = "Installing..."
    $installButton.BackColor = [System.Drawing.Color]::FromArgb(150, 150, 150)
    $installDir = "$env:USERPROFILE\opencode-gemini-proxy"
    $batFile = "$env:USERPROFILE\Desktop\OpenCodeCLI.bat"
    try {
        Update-Progress 10 "Checking Python..."
        if (-not (Test-Command "python")) {
            Update-Progress 15 "Downloading Python..."
            $pythonUrl = "https://www.python.org/ftp/python/3.12.7/python-3.12.7-amd64.exe"
            $pythonInstaller = "$env:TEMP\python-installer.exe"
            if (-not (Download-File $pythonUrl $pythonInstaller)) { throw "Could not download Python" }
            Update-Progress 20 "Installing Python..."
            Start-Process $pythonInstaller -ArgumentList "/quiet", "InstallAllUsers=1", "PrependPath=1", "Include_test=0" -Wait
            Refresh-Path
        }
        Update-Progress 30 "Installing uv..."
        if (-not (Test-Command "uv")) {
            python -m ensurepip --upgrade --default-pip 2>&1 | Out-Null
            pip install uv --user 2>&1 | Out-Null
            $uvPath = Get-UvPath
            if ($uvPath) { Add-ToPath -directory (Split-Path $uvPath -Parent); Refresh-Path }
        }
        Update-Progress 40 "Installing Git..."
        if (-not (Test-Command "git")) {
            $gitUrl = "https://github.com/git-for-windows/git/releases/download/v2.47.0.windows.1/Git-2.47.0-64-bit.exe"
            $gitInstaller = "$env:TEMP\git-installer.exe"
            Download-File $gitUrl $gitInstaller
            Start-Process $gitInstaller -ArgumentList "/VERYSILENT", "/NORESTART" -Wait
            Refresh-Path
        }
        Update-Progress 50 "Downloading OpenCode Proxy..."
        if (Test-Path $installDir) { Remove-Item $installDir -Recurse -Force }
        git clone https://github.com/Alishahryar1/free-claude-code.git $installDir
        Update-Progress 70 "Configuring API Key..."
        $apiKey = Get-GoogleAPIKey
        if ([string]::IsNullOrEmpty($apiKey)) { throw "No API Key provided" }
        Update-Progress 80 "Configuring environment..."
        $envContent = @"
# Google Config
GOOGLE_API_KEY="$apiKey"
# OpenRouter Config
OPENROUTER_API_KEY=""
# LM Studio Config
LM_STUDIO_BASE_URL="http://localhost:1234/v1"
# Model mapping
MODEL="google/gemma-4-31b-it"
MODEL_OPUS="google/gemma-4-31b-it"
MODEL_SONNET="google/gemma-4-31b-it"
MODEL_HAIKU="google/gemma-4-31b-it"
PROVIDER_RATE_LIMIT=40
PROVIDER_RATE_WINDOW=60
PROVIDER_MAX_CONCURRENCY=5
HTTP_READ_TIMEOUT=120
HTTP_WRITE_TIMEOUT=10
HTTP_CONNECT_TIMEOUT=2
MESSAGING_PLATFORM="none"
CLAUDE_WORKSPACE="./agent_workspace"
"@
        $envContent | Out-File -FilePath "$installDir\.env" -Encoding UTF8
        Update-Progress 85 "Installing dependencies..."
        Set-Location -Path $installDir
        uv sync 2>&1 | Out-Null
        Set-Location -Path $env:USERPROFILE
        Update-Progress 90 "Creating shortcuts..."
        $batContent = @"
@echo off
setlocal
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Please run as administrator.
    pause & exit /b 1
)
set "ROOT=%USERPROFILE%\opencode-gemini-proxy"
set "PATH=%ROOT%\.venv\Scripts;%PATH%"
set "PATH=%PATH%;%APPDATA%\Python\Scripts"
for /f "tokens=5" %%a in ('netstat -ano 2^>nul ^| findstr ":8082 "') do taskkill /PID %%a /F >nul 2>&1
echo Starting OpenCode CLI Server...
start /B "" cmd /c "cd /d %ROOT% && .venv\Scripts\uvicorn server:app --host 0.0.0.0 --port 8082" >nul 2>&1
timeout /t 5 >nul
set "ANTHROPIC_AUTH_TOKEN=freecc"
set "ANTHROPIC_BASE_URL=http://localhost:8082"
echo Opening OpenCode CLI...
cd /d "%ROOT%"
start /B "" cmd /c "claude"
echo OpenCode CLI is running. This window will close when it exits.
:wait_claude
timeout /t 3 >nul
tasklist /FI "IMAGENAME eq node.exe" 2>nul | find /I /C "node" >nul
if errorlevel 1 (
    tasklist /FI "IMAGENAME eq claude.exe" 2>nul | find /I /C "claude" >nul
    if errorlevel 1 goto claude_done
)
goto wait_claude
:claude_done
for /f "tokens=5" %%a in ('netstat -ano 2^>nul ^| findstr ":8082 "') do taskkill /PID %%a /F >nul 2>&1
exit /b 0
"@
        $batContent | Out-File -FilePath $batFile -Encoding ASCII
        Update-Progress 100 "Installation completed!"
        [System.Windows.Forms.MessageBox]::Show("Installation completed successfully!`n`nTo use OpenCode CLI:`n1. Double-click 'OpenCodeCLI.bat' on your Desktop`n2. Wait for the server to start`n3. OpenCode CLI will open automatically", "Success")
    } catch {
        Update-Progress 100 "Error"
        Cleanup-OnFailure $_
        [System.Windows.Forms.MessageBox]::Show("Error: $_", "Installation Error")
        $installButton.Enabled = $true
        $installButton.Text = "Retry Installation"
    }
}

$installButton.Add_Click({ Start-Installation })
$form.ShowDialog() | Out-Null

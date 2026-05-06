# Free Claude Code Graphical Installer for Windows 11
# Complete installation with graphical interface

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create main form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Free Claude Code Installer"
$form.Size = New-Object System.Drawing.Size(650, 550)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false
$form.BackColor = [System.Drawing.Color]::FromArgb(240, 240, 240)

# Title
$titleLabel = New-Object System.Windows.Forms.Label
$titleLabel.Text = "Free Claude Code - Installer"
$titleLabel.Font = New-Object System.Drawing.Font("Segoe UI", 18, [System.Drawing.FontStyle]::Bold)
$titleLabel.Location = New-Object System.Drawing.Point(20, 20)
$titleLabel.Size = New-Object System.Drawing.Size(610, 40)
$titleLabel.TextAlign = "MiddleCenter"
$titleLabel.ForeColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$form.Controls.Add($titleLabel)

# Description
$descLabel = New-Object System.Windows.Forms.Label
$descLabel.Text = "This installer will set up everything you need to run Claude Code for FREE using NVIDIA NIM."
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
$installButton.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$installButton.ForeColor = [System.Drawing.Color]::White
$installButton.FlatStyle = "Flat"
$installButton.FlatAppearance.BorderSize = 0
$installButton.Cursor = [System.Windows.Forms.Cursors]::Hand
$form.Controls.Add($installButton)

# Function to write to log
function Write-Log {
    param([string]$message)
    $timestamp = Get-Date -Format "HH:mm:ss"
    $logTextBox.AppendText("[$timestamp] $message`r`n")
    $logTextBox.ScrollToCaret()
    $form.Refresh()
}

# Function to update progress
function Update-Progress {
    param([int]$value, [string]$status)
    $progressBar.Value = $value
    $statusLabel.Text = $status
    $form.Refresh()
}

# Function to check if command exists
function Test-Command {
    param([string]$command)
    try {
        $null = Get-Command $command -ErrorAction Stop
        return $true
    } catch {
        return $false
    }
}

# Function to download file
function Download-File {
    param(
        [string]$url,
        [string]$output
    )
    try {
        $webClient = New-Object System.Net.WebClient
        $webClient.DownloadFile($url, $output)
        return $true
    } catch {
        Write-Log "ERROR downloading: $_"
        return $false
    }
}

# Function to show API key dialog
function Get-NVIDIAAPIKey {
    $keyForm = New-Object System.Windows.Forms.Form
    $keyForm.Text = "NVIDIA NIM API Key"
    $keyForm.Size = New-Object System.Drawing.Size(550, 400)
    $keyForm.StartPosition = "CenterScreen"
    $keyForm.FormBorderStyle = "FixedDialog"
    $keyForm.MaximizeBox = $false
    $keyForm.BackColor = [System.Drawing.Color]::FromArgb(240, 240, 240)

    $infoLabel = New-Object System.Windows.Forms.Label
    $infoLabel.Text = "To get your FREE NVIDIA NIM API Key:`r`n`r`n1. Go to: https://build.nvidia.com/settings/api-keys`r`n2. Sign in or create a FREE account`r`n3. Create a new API Key`r`n4. Copy and paste the key below`r`n`r`nThe key will have the format: nvapi-xxxxxxxxxxxx"
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
    $linkLabel.Text = "Open https://build.nvidia.com/settings/api-keys"
    $linkLabel.Location = New-Object System.Drawing.Point(20, 205)
    $linkLabel.Size = New-Object System.Drawing.Size(510, 20)
    $linkLabel.Font = New-Object System.Drawing.Font("Segoe UI", 9)
    $linkLabel.LinkColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
    $linkLabel.Add_Click({
        Start-Process "https://build.nvidia.com/settings/api-keys"
    })
    $keyForm.Controls.Add($linkLabel)

    $noteLabel = New-Object System.Windows.Forms.Label
    $noteLabel.Text = "Note: The API Key is completely FREE. No credit card required.`r`nYou get 40 requests per minute for free."
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
    $okButton.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
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

# Function to cleanup on failure
function Cleanup-OnFailure {
    param([string]$reason)

    Write-Log "=========================================="
    Write-Log "INSTALLATION FAILED: $reason"
    Write-Log "Cleaning up..."
    Write-Log "=========================================="

    $installDir = "$env:USERPROFILE\claude-nvidia-proxy"
    $batFile = "$env:USERPROFILE\Desktop\ClaudeCode.bat"

    # Stop any running processes
    try {
        Write-Log "Stopping any running processes..."
        # Stop processes using port 8082
        $processes = Get-NetTCPConnection -LocalPort 8082 -ErrorAction SilentlyContinue
        if ($processes) {
            foreach ($proc in $processes) {
                try {
                    $process = Get-Process -Id $proc.OwningProcess -ErrorAction SilentlyContinue
                    if ($process) {
                        Write-Log "Stopping process $($process.ProcessName) (PID: $($process.Id))"
                        Stop-Process -Id $process.Id -Force -ErrorAction SilentlyContinue
                    }
                } catch {
                    # Ignore errors when stopping processes
                }
            }
        }

        # Stop any python processes in the installation directory
        if (Test-Path $installDir) {
            Get-Process -Name python -ErrorAction SilentlyContinue | Where-Object {
                $_.Path -like "$installDir*"
            } | ForEach-Object {
                Write-Log "Stopping Python process (PID: $($_.Id))"
                Stop-Process -Id $_.Id -Force -ErrorAction SilentlyContinue
            }
        }

        # Change current directory away from installation directory
        try {
            Set-Location -Path $env:USERPROFILE -ErrorAction SilentlyContinue
            Write-Log "Changed current directory to user profile"
        } catch {
            Write-Log "WARNING: Could not change directory: $_"
        }

        Start-Sleep -Seconds 3
    } catch {
        Write-Log "WARNING: Error stopping processes: $_"
    }

    # Remove cloned repository
    if (Test-Path $installDir) {
        try {
            Write-Log "Removing cloned repository..."
            # Try multiple methods to delete
            $attempts = 0
            $maxAttempts = 5
            $removed = $false

            while ($attempts -lt $maxAttempts -and -not $removed) {
                try {
                    # Method 1: Standard Remove-Item
                    Remove-Item $installDir -Recurse -Force -ErrorAction Stop
                    Write-Log "Repository removed using Remove-Item."
                    $removed = $true
                    break
                } catch {
                    $attempts++
                    Write-Log "Attempt $attempts failed: $_"

                    if ($attempts -lt $maxAttempts) {
                        # Wait longer between attempts
                        $waitTime = $attempts * 2
                        Write-Log "Waiting ${waitTime} seconds before retry..."
                        Start-Sleep -Seconds $waitTime

                        # Try using robocopy to empty the directory first
                        if ($attempts -eq 2) {
                            Write-Log "Trying robocopy to empty directory..."
                            $emptyDir = "$env:TEMP\empty_dir_$(Get-Random)"
                            New-Item -ItemType Directory -Path $emptyDir -Force | Out-Null
                            robocopy $emptyDir $installDir /MIR /R:0 /W:0 /NFL /NDL /NJH /NJS | Out-Null
                            Remove-Item $emptyDir -Force -ErrorAction SilentlyContinue
                            Start-Sleep -Seconds 2
                        }
                    }
                }
            }

            if (-not $removed) {
                Write-Log "WARNING: Could not remove repository after $maxAttempts attempts"
                Write-Log "You may need to manually delete: $installDir"
                Write-Log "Or restart your computer and try again"
            }
        } catch {
            Write-Log "WARNING: Could not remove repository: $_"
        }
    }

    # Remove desktop shortcut
    if (Test-Path $batFile) {
        try {
            Write-Log "Removing desktop shortcut..."
            Remove-Item $batFile -Force -ErrorAction Stop
            Write-Log "Shortcut removed."
        } catch {
            Write-Log "WARNING: Could not remove shortcut: $_"
        }
    }

    Write-Log "Cleanup completed."
}

# Function to get uv executable path
function Get-UvPath {
    # Common uv installation locations
    $uvPaths = @(
        "$env:USERPROFILE\.cargo\bin\uv.exe",
        "$env:USERPROFILE\.local\bin\uv.exe",
        "$env:APPDATA\Python\Scripts\uv.exe",
        "$env:APPDATA\Python\Python312\Scripts\uv.exe",
        "$env:APPDATA\Python\Python311\Scripts\uv.exe",
        "$env:APPDATA\Python\Python310\Scripts\uv.exe",
        "$env:LOCALAPPDATA\Programs\Python\Python312\Scripts\uv.exe",
        "$env:LOCALAPPDATA\Programs\Python\Python311\Scripts\uv.exe",
        "$env:LOCALAPPDATA\Programs\Python\Python310\Scripts\uv.exe",
        "C:\Program Files\Python312\Scripts\uv.exe",
        "C:\Program Files\Python311\Scripts\uv.exe",
        "C:\Program Files\Python310\Scripts\uv.exe"
    )

    foreach ($path in $uvPaths) {
        if (Test-Path $path) {
            return $path
        }
    }

    return $null
}

# Function to add directory to PATH permanently
function Add-ToPath {
    param([string]$directory)

    if (-not (Test-Path $directory)) {
        return $false
    }

    try {
        # Get current PATH
        $currentPath = [System.Environment]::GetEnvironmentVariable("Path", "User")

        # Check if already in PATH
        if ($currentPath -notlike "*$directory*") {
            Write-Log "Adding $directory to PATH..."
            $newPath = "$directory;$currentPath"
            [System.Environment]::SetEnvironmentVariable("Path", $newPath, "User")
            Write-Log "Added to PATH successfully."
            return $true
        } else {
            Write-Log "Already in PATH."
            return $true
        }
    } catch {
        Write-Log "ERROR: Could not add to PATH: $_"
        return $false
    }
}

# Function to refresh PATH for current session
function Refresh-Path {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

# Main installation function
function Start-Installation {
    $installButton.Enabled = $false
    $installButton.Text = "Installing..."
    $installButton.BackColor = [System.Drawing.Color]::FromArgb(150, 150, 150)

    # Define installation paths
    $installDir = "$env:USERPROFILE\claude-nvidia-proxy"
    $batFile = "$env:USERPROFILE\Desktop\ClaudeCode.bat"

    try {
        # Step 1: Check/Install Python
        Update-Progress 10 "Checking Python..."
        Write-Log "Checking Python installation..."

        if (-not (Test-Command "python")) {
            Write-Log "Python not found. Downloading installer..."
            Update-Progress 15 "Downloading Python..."

            $pythonUrl = "https://www.python.org/ftp/python/3.12.7/python-3.12.7-amd64.exe"
            $pythonInstaller = "$env:TEMP\python-installer.exe"

            if (-not (Download-File $pythonUrl $pythonInstaller)) {
                throw "Could not download Python"
            }

            Write-Log "Installing Python (this may take several minutes)..."
            Update-Progress 20 "Installing Python..."

            $process = Start-Process $pythonInstaller -ArgumentList "/quiet", "InstallAllUsers=1", "PrependPath=1", "Include_test=0" -Wait -PassThru

            if ($process.ExitCode -ne 0) {
                throw "Error installing Python"
            }

            Write-Log "Python installed successfully."
            Remove-Item $pythonInstaller -Force

            # Refresh PATH
            Refresh-Path
            Start-Sleep -Seconds 3
        } else {
            $pythonVersion = python --version 2>&1
            Write-Log "Python found: $pythonVersion"
        }

        # Step 2: Install uv
        Update-Progress 30 "Installing uv..."
        Write-Log "Installing uv package manager..."

        $uvPath = $null

        if (-not (Test-Command "uv")) {
            try {
                # First, try to find if uv is already installed but not in PATH
                Write-Log "Checking if uv is already installed..."
                $uvPath = Get-UvPath

                if ($uvPath) {
                    Write-Log "Found uv at: $uvPath"
                    Write-Log "Adding uv directory to PATH..."
                    $uvDir = Split-Path $uvPath -Parent
                    Add-ToPath -directory $uvDir
                    Refresh-Path
                } else {
                    # Install uv using pip (more reliable)
                    Write-Log "Installing uv via pip (more reliable method)..."

                    # Ensure pip is available
                    if (-not (Test-Command "pip")) {
                        Write-Log "pip not found, installing ensurepip..."
                        python -m ensurepip --upgrade --default-pip 2>&1 | Out-Null
                        Refresh-Path
                        Start-Sleep -Seconds 2
                    }

                    if (Test-Command "pip") {
                        Write-Log "Installing uv via pip install --user..."
                        $pipResult = pip install uv --user 2>&1
                        Write-Log "pip install result: $pipResult"

                        # Wait for installation to complete
                        Start-Sleep -Seconds 5

                        # Find where uv was installed
                        Write-Log "Searching for uv installation..."
                        $uvPath = Get-UvPath

                        if ($uvPath) {
                            Write-Log "Found uv at: $uvPath"
                            $uvDir = Split-Path $uvPath -Parent
                            Add-ToPath -directory $uvDir
                            Refresh-Path
                            Start-Sleep -Seconds 2

                            # Verify it works
                            $uvVersion = & $uvPath --version 2>&1
                            Write-Log "uv installed successfully. Version: $uvVersion"
                        } else {
                            Write-Log "ERROR: uv installation completed but could not find uv.exe"
                            Write-Log "Searching in common locations..."

                            # List all Python Scripts directories
                            $scriptDirs = @(
                                "$env:APPDATA\Python\Scripts",
                                "$env:APPDATA\Python\Python312\Scripts",
                                "$env:APPDATA\Python\Python311\Scripts",
                                "$env:APPDATA\Python\Python310\Scripts",
                                "$env:LOCALAPPDATA\Programs\Python\Python312\Scripts",
                                "$env:LOCALAPPDATA\Programs\Python\Python311\Scripts",
                                "$env:LOCALAPPDATA\Programs\Python\Python310\Scripts",
                                "C:\Program Files\Python312\Scripts",
                                "C:\Program Files\Python311\Scripts"
                            )

                            foreach ($dir in $scriptDirs) {
                                if (Test-Path $dir) {
                                    Write-Log "Contents of ${dir}:"
                                    Get-ChildItem $dir -Filter "*.exe" | ForEach-Object {
                                        Write-Log "  - $($_.Name)"
                                    }
                                }
                            }

                            throw "Could not find uv.exe after installation"
                        }
                    } else {
                        throw "pip not available and could not install ensurepip"
                    }
                }
            } catch {
                Write-Log "ERROR installing uv: $_"
                Cleanup-OnFailure "uv installation failed"
                throw
            }
        } else {
            $uvVersion = uv --version 2>&1
            Write-Log "uv is already installed. Version: $uvVersion"
            $uvPath = "uv"
        }

        # Store uv path for later use
        $script:uvPath = $uvPath

        # Step 3: Install Git
        Update-Progress 40 "Installing Git..."
        Write-Log "Checking Git installation..."

        if (-not (Test-Command "git")) {
            try {
                Write-Log "Git not found. Downloading Git installer..."
                $gitUrl = "https://github.com/git-for-windows/git/releases/download/v2.47.0.windows.1/Git-2.47.0-64-bit.exe"
                $gitInstaller = "$env:TEMP\git-installer.exe"

                if (-not (Download-File $gitUrl $gitInstaller)) {
                    throw "Could not download Git"
                }

                Write-Log "Installing Git (this may take several minutes)..."
                Update-Progress 45 "Installing Git..."

                $process = Start-Process $gitInstaller -ArgumentList "/VERYSILENT", "/NORESTART", "/NOCANCEL", "/SP-", "/DIR=`"C:\Program Files\Git`"", "/COMPONENTS=`"icons,ext\shellhere,assoc,assoc_sh`"" -Wait -PassThru

                if ($process.ExitCode -ne 0) {
                    throw "Error installing Git"
                }

                Write-Log "Git installed successfully."
                Remove-Item $gitInstaller -Force

                # Refresh PATH
                Refresh-Path
                Start-Sleep -Seconds 5

                # Verify installation
                $gitFound = $false
                for ($i = 0; $i -lt 3; $i++) {
                    if (Test-Command "git") {
                        $gitFound = $true
                        $gitVersion = git --version 2>&1
                        Write-Log "Git verified. Version: $gitVersion"
                        break
                    }
                    Write-Log "Attempt $($i + 1): git not found in PATH, waiting..."
                    Start-Sleep -Seconds 3
                    Refresh-Path
                }

                if (-not $gitFound) {
                    Write-Log "WARNING: Git installation completed but command not found in PATH"
                    Write-Log "You may need to restart your terminal or system"
                }
            } catch {
                Write-Log "ERROR installing Git: $_"
                Cleanup-OnFailure "Git installation failed"
                throw
            }
        } else {
            $gitVersion = git --version 2>&1
            Write-Log "Git is already installed. Version: $gitVersion"
        }

        # Step 4: Clone repository
        Update-Progress 50 "Downloading claude-nvidia-proxy..."
        Write-Log "Cloning claude-nvidia-proxy repository..."

        if (Test-Path $installDir) {
            Write-Log "Directory already exists, removing..."
            try {
                Remove-Item $installDir -Recurse -Force
            } catch {
                Write-Log "ERROR: Could not remove existing directory: $_"
                Cleanup-OnFailure "Could not remove existing directory"
                throw
            }
        }

        try {
            $gitResult = git clone https://github.com/Tutevinho/claude-nvidia-proxy.git $installDir 2>&1
            if ($LASTEXITCODE -ne 0) {
                throw "Error cloning repository: $gitResult"
            }
        } catch {
            Write-Log "ERROR: Failed to clone repository: $_"
            Cleanup-OnFailure "Repository cloning failed"
            throw
        }

        Write-Log "Repository cloned successfully."

        # Step 5: Request API Key
        Update-Progress 70 "Configuring API Key..."
        Write-Log "Requesting NVIDIA NIM API Key..."

        $apiKey = Get-NVIDIAAPIKey
        if ([string]::IsNullOrEmpty($apiKey)) {
            Write-Log "ERROR: No API Key provided"
            Cleanup-OnFailure "No API Key provided"
            throw "No API Key provided"
        }

        if (-not $apiKey.StartsWith("nvapi-")) {
            Write-Log "ERROR: API Key must start with 'nvapi-'"
            Cleanup-OnFailure "Invalid API Key format"
            throw "API Key must start with 'nvapi-'"
        }

        Write-Log "API Key received."

        # Step 6: Configure .env
        Update-Progress 80 "Configuring environment..."
        Write-Log "Configuring .env file..."

        try {
            $envFile = "$installDir\.env"
            $envContent = @"
# NVIDIA NIM Config
NVIDIA_NIM_API_KEY="$apiKey"

# OpenRouter Config
OPENROUTER_API_KEY=""

# LM Studio Config (local provider, no API key required)
LM_STUDIO_BASE_URL="http://localhost:1234/v1"

# Llama.cpp Config (local provider, no API key required)
LLAMACPP_BASE_URL="http://localhost:8080/v1"

# All Claude model requests are mapped to these models, plain model is fallback
# Format: provider_type/model/name
# Valid providers: "nvidia_nim" | "open_router" | "lmstudio" | "llamacpp"
MODEL=nvidia_nim/z-ai/glm4.7
MODEL_OPUS=nvidia_nim/z-ai/glm4.7
MODEL_SONNET=nvidia_nim/z-ai/glm4.7
MODEL_HAIKU=nvidia_nim/z-ai/glm4.7

# NIM Settings
NIM_ENABLE_THINKING=false

# Provider config
PROVIDER_RATE_LIMIT=40
PROVIDER_RATE_WINDOW=60
PROVIDER_MAX_CONCURRENCY=5

# HTTP client timeouts (seconds) for provider API requests
HTTP_READ_TIMEOUT=120
HTTP_WRITE_TIMEOUT=10
HTTP_CONNECT_TIMEOUT=2

# Optional server API key (Anthropic-style)
ANTHROPIC_AUTH_TOKEN=

# Messaging Platform: "telegram" | "discord"
MESSAGING_PLATFORM=""
MESSAGING_RATE_LIMIT=1
MESSAGING_RATE_WINDOW=1

# Voice Note Transcription
VOICE_NOTE_ENABLED=false
WHISPER_DEVICE="cpu"
WHISPER_MODEL="base"
HF_TOKEN=""

# Telegram Config
TELEGRAM_BOT_TOKEN=""
ALLOWED_TELEGRAM_USER_ID=""

# Discord Config
DISCORD_BOT_TOKEN=""
ALLOWED_DISCORD_CHANNELS=""

# Agent Config
CLAUDE_WORKSPACE="./agent_workspace"
ALLOWED_DIR=""
FAST_PREFIX_DETECTION=true
ENABLE_NETWORK_PROBE_MOCK=true
ENABLE_TITLE_GENERATION_SKIP=true
ENABLE_SUGGESTION_MODE_SKIP=true
ENABLE_FILEPATH_EXTRACTION_MOCK=true
"@

            $envContent | Out-File -FilePath $envFile -Encoding UTF8
            Write-Log ".env file configured."
        } catch {
            Write-Log "ERROR: Failed to configure .env file: $_"
            Cleanup-OnFailure ".env configuration failed"
            throw
        }

        # Step 7: Create startup script
        Update-Progress 90 "Creating shortcuts..."
        Write-Log "Creating startup script..."

        try {
            if (Test-Path $batFile) {
                Write-Log "Desktop shortcut already exists, skipping creation."
            } else {
                # Get the directory where uv is installed
                $uvDir = ""
                if ($script:uvPath -and (Test-Path $script:uvPath)) {
                    $uvDir = Split-Path $script:uvPath -Parent
                    Write-Log "uv directory: $uvDir"
                }

                $batContent = @"
@echo off
setlocal

set "ROOT=%USERPROFILE%\claude-nvidia-proxy"

:: Add uv to PATH if needed
if exist "$uvDir" (
    set "PATH=%PATH%;$uvDir"
)

:: Validations
if not exist "%ROOT%" (
    echo ERROR: Directory %ROOT% does not exist
    pause & exit /b 1
)

:: Kill previous instance if exists
for /f "tokens=5" %%a in ('netstat -ano 2^>nul ^| findstr ":8082 "') do (
    taskkill /PID %%a /F >nul 2>&1
)

:: Start server in separate visible window
echo Starting Free Claude Code Server...
start "Free Claude Code Server" cmd /k "cd /d %ROOT% && uv run uvicorn server:app --host 0.0.0.0 --port 8082"

:: Wait for startup
echo Waiting for server to start...
timeout /t 5 >nul

:: Verify server is responding
curl -s -o nul http://localhost:8082 >nul 2>&1
if errorlevel 1 (
    echo WARNING: Server may not have started correctly. Check the server window.
)

:: Start Claude in user directory
set "ANTHROPIC_AUTH_TOKEN=freecc"
set "ANTHROPIC_BASE_URL=http://localhost:8082"

where claude >nul 2>&1
if errorlevel 1 (
    echo ERROR: "claude" command is not installed or not in PATH.
    echo Installing Claude Code CLI...
    npm install -g @anthropic-ai/claude-code
)

echo Opening Claude Code...
cd /d "%ROOT%"
claude
"@

                $batContent | Out-File -FilePath $batFile -Encoding ASCII
                Write-Log "Startup script created on Desktop."
            }
        } catch {
            Write-Log "ERROR: Failed to create startup script: $_"
            Cleanup-OnFailure "Startup script creation failed"
            throw
        }

        # Step 8: Install dependencies
        Update-Progress 95 "Installing Python dependencies..."
        Write-Log "Installing project dependencies..."

        try {
            Push-Location $installDir

            # Use the stored uv path
            if ($script:uvPath -and (Test-Path $script:uvPath)) {
                Write-Log "Using uv at: $script:uvPath"
                $syncResult = & $script:uvPath sync 2>&1
            } else {
                Write-Log "Using uv from PATH"
                $syncResult = uv sync 2>&1
            }

            if ($LASTEXITCODE -ne 0) {
                Write-Log "WARNING: Some dependencies may not have installed: $syncResult"
                Write-Log "You may need to run 'uv sync' manually in the installation directory"
            } else {
                Write-Log "Dependencies installed successfully."
            }
            Pop-Location
        } catch {
            Write-Log "ERROR: Failed to install dependencies: $_"
            Write-Log "You may need to run 'uv sync' manually in: $installDir"
            # Don't cleanup on dependency failure, as the installation is mostly complete
            Write-Log "Installation completed with warnings."
        }

        # Successful completion
        Update-Progress 100 "Installation completed!"
        Write-Log "=========================================="
        Write-Log "INSTALLATION COMPLETED SUCCESSFULLY!"
        Write-Log "=========================================="
        Write-Log ""
        Write-Log "To use Free Claude Code:"
        Write-Log "1. Double-click 'ClaudeCode.bat' on your Desktop"
        Write-Log "2. Wait for the server to start"
        Write-Log "3. Claude Code will open automatically"
        Write-Log ""
        Write-Log "Installation directory: $installDir"
        Write-Log "API Key configured: $apiKey"

        $installButton.Text = "Installation Completed"
        $installButton.BackColor = [System.Drawing.Color]::FromArgb(0, 180, 0)

        [System.Windows.Forms.MessageBox]::Show(
            "Installation completed successfully!`n`nTo use Free Claude Code:`n1. Double-click 'ClaudeCode.bat' on your Desktop`n2. Wait for the server to start`n3. Claude Code will open automatically",
            "Installation Completed",
            "OK",
            "Information"
        )

    } catch {
        Update-Progress 100 "Installation error"
        Write-Log "=========================================="
        Write-Log "ERROR: $_"
        Write-Log "=========================================="

        # Cleanup if not already done
        if (Test-Path $installDir) {
            Write-Log "Performing cleanup due to installation failure..."
            Cleanup-OnFailure "Installation failed: $_"
        }

        [System.Windows.Forms.MessageBox]::Show(
            "Error during installation:`n`n$_`n`nAll installed files have been cleaned up.`n`nCheck the log for more details.",
            "Installation Error",
            "OK",
            "Error"
        )

        $installButton.Enabled = $true
        $installButton.Text = "Retry Installation"
        $installButton.BackColor = [System.Drawing.Color]::FromArgb(200, 50, 50)
    }
}

# Button click event
$installButton.Add_Click({
    Start-Installation
})

# Show form
$form.ShowDialog() | Out-Null

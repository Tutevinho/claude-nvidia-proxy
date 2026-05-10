# OpenCode CLI Installer for Windows 11
# Simple native installation of OpenCode CLI

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
$titleLabel.ForeColor = [System.Drawing.Color]::FromArgb(66, 133, 244)
$form.Controls.Add($titleLabel)

# Description
$descLabel = New-Object System.Windows.Forms.Label
$descLabel.Text = "This installer will set up OpenCode CLI natively on your system."
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

function Start-Installation {
    $installButton.Enabled = $false
    $installButton.Text = "Installing..."
    $installButton.BackColor = [System.Drawing.Color]::FromArgb(150, 150, 150)

    try {
        # Step 0: Set Execution Policy for the current session
        Write-Log "Configuring PowerShell Execution Policy..."
        Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
        Write-Log "Execution Policy set to Bypass for this session."

        # Step 1: Check/Install Node.js
        Update-Progress 10 "Checking Node.js..."
        Write-Log "Checking Node.js installation..."

        if (-not (Test-Command "node")) {
            Write-Log "Node.js not found. Downloading installer..."
            Update-Progress 15 "Downloading Node.js..."
            $nodeUrl = "https://nodejs.org/dist/v22.14.0/node-v22.14.0-x64.msi"
            $nodeInstaller = "$env:TEMP\node-installer.msi"
            if (-not (Download-File $nodeUrl $nodeInstaller)) { throw "Could not download Node.js" }
            Write-Log "Installing Node.js..."
            Update-Progress 20 "Installing Node.js..."
            $process = Start-Process msiexec.exe -ArgumentList "/i `"$nodeInstaller`" /qn /norestart" -Wait -PassThru
            if ($process.ExitCode -ne 0) { throw "Error installing Node.js" }
            Write-Log "Node.js installed successfully."
            Remove-Item $nodeInstaller -Force
            $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
            Start-Sleep -Seconds 3
        } else {
            $nodeVersion = node -v 2>&1
            Write-Log "Node.js found: $nodeVersion"
        }

        # Step 2: Install OpenCode CLI via npm
        Update-Progress 30 "Installing OpenCode CLI..."
        Write-Log "Installing opencode-ai via npm..."
        if (-not (Test-Command "npm")) { throw "npm not found. Please install Node.js manually." }
        $npmResult = cmd /c "npm install -g opencode-ai@latest" 2>&1
        Write-Log "npm install result: $npmResult"
        if ($LASTEXITCODE -ne 0) { throw "Error installing OpenCode CLI via npm" }

        # Step 3: Create Desktop Shortcut
        Update-Progress 80 "Creating shortcut..."
        Write-Log "Creating OpenCodeCLI.bat on desktop..."
        $batFile = "$env:USERPROFILE\Desktop\OpenCodeCLI.bat"
        $batContent = @"
@echo off
echo Launching OpenCode CLI...
set "PATH=%APPDATA%\npm;%PATH%"
start cmd /k "opencode"
"@
        $batContent | Out-File -FilePath $batFile -Encoding ASCII
        Write-Log "Desktop shortcut created."

        Update-Progress 100 "Installation completed!"
        [System.Windows.Forms.MessageBox]::Show("Installation completed successfully!`n`nTo use OpenCode CLI:`n1. Double-click 'OpenCodeCLI.bat' on your Desktop`n2. The CLI will open automatically", "Success")

    } catch {
        Update-Progress 100 "Error"
        Write-Log "=========================================="
        Write-Log "ERROR: $_"
        Write-Log "=========================================="
        [System.Windows.Forms.MessageBox]::Show("Error during installation:`n`n$_", "Installation Error")
        $installButton.Enabled = $true
        $installButton.Text = "Retry Installation"
    }
}

$installButton.Add_Click({ Start-Installation })
$form.ShowDialog() | Out-Null

# Free Claude Code Graphical Uninstaller for Windows 11
# Complete uninstallation with graphical interface

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create main form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Free Claude Code Uninstaller"
$form.Size = New-Object System.Drawing.Size(550, 450)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false
$form.BackColor = [System.Drawing.Color]::FromArgb(240, 240, 240)

# Title
$titleLabel = New-Object System.Windows.Forms.Label
$titleLabel.Text = "Free Claude Code - Uninstaller"
$titleLabel.Font = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
$titleLabel.Location = New-Object System.Drawing.Point(20, 20)
$titleLabel.Size = New-Object System.Drawing.Size(510, 35)
$titleLabel.TextAlign = "MiddleCenter"
$titleLabel.ForeColor = [System.Drawing.Color]::FromArgb(200, 50, 50)
$form.Controls.Add($titleLabel)

# Description
$descLabel = New-Object System.Windows.Forms.Label
$descLabel.Text = "This uninstaller will remove Free Claude Code and all its files."
$descLabel.Location = New-Object System.Drawing.Point(20, 65)
$descLabel.Size = New-Object System.Drawing.Size(510, 30)
$descLabel.TextAlign = "MiddleCenter"
$descLabel.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$form.Controls.Add($descLabel)

# Options panel
$optionsPanel = New-Object System.Windows.Forms.Panel
$optionsPanel.Location = New-Object System.Drawing.Point(20, 110)
$optionsPanel.Size = New-Object System.Drawing.Size(510, 160)
$optionsPanel.BorderStyle = "FixedSingle"
$optionsPanel.BackColor = [System.Drawing.Color]::White
$form.Controls.Add($optionsPanel)

# Checkbox for directory
$deleteDirCheckBox = New-Object System.Windows.Forms.CheckBox
$deleteDirCheckBox.Text = "Remove claude-nvidia-proxy directory"
$deleteDirCheckBox.Location = New-Object System.Drawing.Point(10, 10)
$deleteDirCheckBox.Size = New-Object System.Drawing.Size(490, 25)
$deleteDirCheckBox.Checked = $true
$deleteDirCheckBox.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$optionsPanel.Controls.Add($deleteDirCheckBox)

# Checkbox for shortcut
$deleteShortcutCheckBox = New-Object System.Windows.Forms.CheckBox
$deleteShortcutCheckBox.Text = "Remove desktop shortcut"
$deleteShortcutCheckBox.Location = New-Object System.Drawing.Point(10, 40)
$deleteShortcutCheckBox.Size = New-Object System.Drawing.Size(490, 25)
$deleteShortcutCheckBox.Checked = $true
$deleteShortcutCheckBox.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$optionsPanel.Controls.Add($deleteShortcutCheckBox)

# Checkbox for Python
$deletePythonCheckBox = New-Object System.Windows.Forms.CheckBox
$deletePythonCheckBox.Text = "Remove Python (NOT RECOMMENDED)"
$deletePythonCheckBox.Location = New-Object System.Drawing.Point(10, 70)
$deletePythonCheckBox.Size = New-Object System.Drawing.Size(490, 25)
$deletePythonCheckBox.Checked = $false
$deletePythonCheckBox.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$deletePythonCheckBox.ForeColor = [System.Drawing.Color]::FromArgb(200, 50, 50)
$optionsPanel.Controls.Add($deletePythonCheckBox)

# Checkbox for uv
$deleteUvCheckBox = New-Object System.Windows.Forms.CheckBox
$deleteUvCheckBox.Text = "Remove uv (NOT RECOMMENDED)"
$deleteUvCheckBox.Location = New-Object System.Drawing.Point(10, 100)
$deleteUvCheckBox.Size = New-Object System.Drawing.Size(490, 25)
$deleteUvCheckBox.Checked = $false
$deleteUvCheckBox.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$deleteUvCheckBox.ForeColor = [System.Drawing.Color]::FromArgb(200, 50, 50)
$optionsPanel.Controls.Add($deleteUvCheckBox)

# Progress log
$logTextBox = New-Object System.Windows.Forms.TextBox
$logTextBox.Multiline = $true
$logTextBox.ScrollBars = "Vertical"
$logTextBox.ReadOnly = $true
$logTextBox.Location = New-Object System.Drawing.Point(20, 280)
$logTextBox.Size = New-Object System.Drawing.Size(510, 80)
$logTextBox.Font = New-Object System.Drawing.Font("Consolas", 8)
$logTextBox.BackColor = [System.Drawing.Color]::FromArgb(250, 250, 250)
$form.Controls.Add($logTextBox)

# Function to write to log
function Write-Log {
    param([string]$message)
    $timestamp = Get-Date -Format "HH:mm:ss"
    $logTextBox.AppendText("[$timestamp] $message`r`n")
    $logTextBox.ScrollToCaret()
    $form.Refresh()
}

# Function to stop server
function Stop-Server {
    Write-Log "Checking if server is running..."

    try {
        $processes = Get-NetTCPConnection -LocalPort 8082 -ErrorAction SilentlyContinue
        if ($processes) {
            Write-Log "Server detected on port 8082"
            foreach ($proc in $processes) {
                try {
                    $process = Get-Process -Id $proc.OwningProcess -ErrorAction SilentlyContinue
                    if ($process) {
                        Write-Log "Stopping process $($process.ProcessName) (PID: $($process.Id))"
                        Stop-Process -Id $process.Id -Force
                        Start-Sleep -Seconds 2
                    }
                } catch {
                    Write-Log "Could not stop process: $_"
                }
            }
        } else {
            Write-Log "No server running on port 8082"
        }
    } catch {
        Write-Log "Error checking server: $_"
    }
}

# Main uninstallation function
function Start-Uninstallation {
    $result = [System.Windows.Forms.MessageBox]::Show(
        "Are you sure you want to uninstall Free Claude Code?`n`nThis action cannot be undone.",
        "Confirm Uninstallation",
        "YesNo",
        "Warning"
    )

    if ($result -ne "Yes") {
        Write-Log "Uninstallation cancelled by user."
        return
    }

    Write-Log "Starting uninstallation..."

    # Stop server
    Stop-Server

    # Remove directory
    if ($deleteDirCheckBox.Checked) {
        Write-Log "Removing claude-nvidia-proxy directory..."
        $installDir = "$env:USERPROFILE\claude-nvidia-proxy"

        if (Test-Path $installDir) {
            try {
                Remove-Item $installDir -Recurse -Force
                Write-Log "Directory removed successfully."
            } catch {
                Write-Log "ERROR removing directory: $_"
            }
        } else {
            Write-Log "Directory does not exist."
        }
    }

    # Remove shortcut
    if ($deleteShortcutCheckBox.Checked) {
        Write-Log "Removing desktop shortcut..."
        $shortcutPath = "$env:USERPROFILE\Desktop\ClaudeCode.bat"

        if (Test-Path $shortcutPath) {
            try {
                Remove-Item $shortcutPath -Force
                Write-Log "Shortcut removed successfully."
            } catch {
                Write-Log "ERROR removing shortcut: $_"
            }
        } else {
            Write-Log "Shortcut does not exist."
        }
    }

    # Remove Python
    if ($deletePythonCheckBox.Checked) {
        Write-Log "WARNING: Removing Python..."
        try {
            $pythonInstallDir = "C:\Program Files\Python312"
            if (Test-Path $pythonInstallDir) {
                Write-Log "This may take several minutes..."
                $uninstallExe = "$pythonInstallDir\unins000.exe"
                if (Test-Path $uninstallExe) {
                    Start-Process $uninstallExe -ArgumentList "/SILENT" -Wait
                    Write-Log "Python uninstalled."
                } else {
                    Write-Log "Python uninstaller not found."
                }
            } else {
                Write-Log "Python not found in expected location."
            }
        } catch {
            Write-Log "ERROR uninstalling Python: $_"
        }
    }

    # Remove uv
    if ($deleteUvCheckBox.Checked) {
        Write-Log "WARNING: Removing uv..."
        try {
            $uvPath = "$env:USERPROFILE\.cargo\bin\uv.exe"
            if (Test-Path $uvPath) {
                Remove-Item $uvPath -Force
                Write-Log "uv removed."
            } else {
                Write-Log "uv not found in expected location."
            }
        } catch {
            Write-Log "ERROR removing uv: $_"
        }
    }

    Write-Log "=========================================="
    Write-Log "UNINSTALLATION COMPLETED!"
    Write-Log "=========================================="

    [System.Windows.Forms.MessageBox]::Show(
        "Uninstallation completed.`n`nSome files may require a system restart to be completely removed.",
        "Uninstallation Completed",
        "OK",
        "Information"
    )

    $form.Close()
}

# Uninstall button
$uninstallButton = New-Object System.Windows.Forms.Button
$uninstallButton.Text = "Uninstall"
$uninstallButton.Location = New-Object System.Drawing.Point(20, 370)
$uninstallButton.Size = New-Object System.Drawing.Size(510, 45)
$uninstallButton.Font = New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
$uninstallButton.BackColor = [System.Drawing.Color]::FromArgb(200, 50, 50)
$uninstallButton.ForeColor = [System.Drawing.Color]::White
$uninstallButton.FlatStyle = "Flat"
$uninstallButton.FlatAppearance.BorderSize = 0
$uninstallButton.Cursor = [System.Windows.Forms.Cursors]::Hand
$uninstallButton.Add_Click({
    Start-Uninstallation
})
$form.Controls.Add($uninstallButton)

# Cancel button
$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Text = "Cancel"
$cancelButton.Location = New-Object System.Drawing.Point(20, 370)
$cancelButton.Size = New-Object System.Drawing.Size(510, 45)
$cancelButton.Font = New-Object System.Drawing.Font("Segoe UI", 12)
$cancelButton.BackColor = [System.Drawing.Color]::FromArgb(100, 100, 100)
$cancelButton.ForeColor = [System.Drawing.Color]::White
$cancelButton.FlatStyle = "Flat"
$cancelButton.FlatAppearance.BorderSize = 0
$cancelButton.Add_Click({
    $form.Close()
})
$form.Controls.Add($cancelButton)

# Initially hide uninstall button
$uninstallButton.Visible = $false

# Checkbox change events
$deleteDirCheckBox.Add_CheckedChanged({
    if ($deleteDirCheckBox.Checked -or $deleteShortcutCheckBox.Checked) {
        $uninstallButton.Visible = $true
        $cancelButton.Visible = $false
    } else {
        $uninstallButton.Visible = $false
        $cancelButton.Visible = $true
    }
})

$deleteShortcutCheckBox.Add_CheckedChanged({
    if ($deleteDirCheckBox.Checked -or $deleteShortcutCheckBox.Checked) {
        $uninstallButton.Visible = $true
        $cancelButton.Visible = $false
    } else {
        $uninstallButton.Visible = $false
        $cancelButton.Visible = $true
    }
})

# Show form
$form.ShowDialog() | Out-Null

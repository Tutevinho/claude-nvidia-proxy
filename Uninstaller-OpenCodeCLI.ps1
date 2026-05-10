# OpenCode CLI Uninstaller for Windows 11
Add-Type -AssemblyName System.Windows.Forms
$form = New-Object System.Windows.Forms.Form
$form.Text = "OpenCode CLI Uninstaller"
$form.Size = New-Object System.Drawing.Size(400, 200)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false

$label = New-Object System.Windows.Forms.Label
$label.Text = "Are you sure you want to uninstall OpenCode CLI?`nThis will remove the binary and the desktop shortcut."
$label.Location = New-Object System.Drawing.Point(20, 30)
$label.Size = New-Object System.Drawing.Size(360, 60)
$label.TextAlign = "MiddleCenter"
$form.Controls.Add($label)

$yesButton = New-Object System.Windows.Forms.Button
$yesButton.Text = "Yes, Uninstall"
$yesButton.Location = New-Object System.Drawing.Point(80, 110)
$yesButton.Size = New-Object System.Drawing.Size(120, 35)
$yesButton.DialogResult = "OK"
$form.Controls.Add($yesButton)

$noButton = New-Object System.Windows.Forms.Button
$noButton.Text = "Cancel"
$noButton.Location = New-Object System.Drawing.Point(200, 110)
$noButton.Size = New-Object System.Drawing.Size(120, 35)
$noButton.DialogResult = "Cancel"
$form.Controls.Add($noButton)

if ($form.ShowDialog() -eq "OK") {
    try {
        npm uninstall -g opencode-ai
        $batFile = "$env:USERPROFILE\Desktop\OpenCodeCLI.bat"
        if (Test-Path $batFile) { Remove-Item $batFile -Force }
        [System.Windows.Forms.MessageBox]::Show("OpenCode CLI has been successfully uninstalled.", "Success")
    } catch {
        [System.Windows.Forms.MessageBox]::Show("Error during uninstall: $_", "Error")
    }
}

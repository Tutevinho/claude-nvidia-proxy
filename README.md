# Free Claude Code Installer for Windows 11

## ⚡ Quick Install (No Download Required)

### 🚀 Install with One Command

Copy and paste this command in PowerShell (Run as Administrator):

```powershell
irm https://raw.githubusercontent.com/Tutevinho/claude-nvidia-proxy/main/Installer-FreeClaudeCode.ps1 | iex
```

### 🗑️ Uninstall with One Command

Copy and paste this command in PowerShell (Run as Administrator):

```powershell
irm https://raw.githubusercontent.com/Tutevinho/claude-nvidia-proxy/main/Uninstaller-FreeClaudeCode.ps1 | iex
```

---

## 🚀 Quick Start

### 3 Simple Steps to Get Started:

1. **Get Your Free API Key**
   - Go to: https://build.nvidia.com/settings/api-keys
   - Create a free account (if you don't have one)
   - Generate an API Key
   - The key will look like: `nvapi-xxxxxxxxxxxx`

2. **Run the Installer**
   - Right-click on `Install-FreeClaudeCode.bat`
   - Select "Run as administrator"
   - Follow the graphical installer prompts
   - Paste your API Key when requested

3. **Start Using!**
   - Double-click on `ClaudeCode.bat` on your desktop
   - Wait for the server to start
   - Claude Code will open automatically

## 📦 What's Included

- **Install-FreeClaudeCode.bat** - Main installer launcher
- **Installer-FreeClaudeCode.ps1** - Graphical installation script
- **Uninstall-FreeClaudeCode.bat** - Uninstaller launcher
- **Uninstaller-FreeClaudeCode.ps1** - Graphical uninstallation script
- **README.md** - This file

## ⏱️ Installation Time

- If you already have Python and Git: ~5-10 minutes
- If you need Python and/or Git installed: ~15-25 minutes

**Note:** Python and Git installation may take several minutes. Please be patient.

## 💡 System Requirements

- ✅ Windows 11 (recommended) or Windows 10
- ✅ 4 GB RAM minimum (8 GB recommended)
- ✅ 2 GB free disk space
- ✅ Internet connection
- ✅ Administrator permissions

## 🔧 What Gets Installed

The installer will automatically set up:

1. **Python 3.12.7** - If not already installed
2. **uv** - Modern Python package manager
3. **Git** - For cloning the repository (if not installed)
4. **claude-nvidia-proxy** - The main project
5. **Python Dependencies** - FastAPI, uvicorn, httpx, etc.
6. **ClaudeCode.bat** - Desktop shortcut
7. **Claude Code CLI** - If not already installed

## 🗑️ Uninstallation

To uninstall:

1. Run `Uninstall-FreeClaudeCode.bat` as administrator
2. Select which components to remove
3. Confirm uninstallation

## ⚠️ Troubleshooting

### "Cannot run installer"
- Run as administrator
- Verify all files are in the same folder

### "Python not found"
- The installer will install Python automatically
- If it fails, download Python from: https://www.python.org/downloads/

### "Invalid API Key"
- Make sure it starts with "nvapi-"
- Check for extra spaces

### "Server not responding"
- Wait 10-15 seconds after starting
- Check if firewall is blocking port 8082

## 📚 Documentation

For detailed instructions, advanced configuration, and more troubleshooting, visit the original project:

**https://github.com/Alishahryar1/free-claude-code**

## 🎮 What is Free Claude Code?

Free Claude Code allows you to use Claude Code (Anthropic's CLI) completely FREE using NVIDIA NIM.

- ✅ 40 requests per minute for free
- ✅ No Anthropic API key needed
- ✅ Same functionality as paid version
- ✅ Support for multiple AI models

## 🙏 Credits

- Original project: https://github.com/Alishahryar1/free-claude-code
- NVIDIA NIM for the free API
- Anthropic for Claude Code

## 📞 Support

For installation issues:
- Check the installation log for error messages
- Ensure you're running as administrator
- Verify internet connection
- Check Windows Defender/Antivirus settings

For claude-nvidia-proxy issues:
- Visit: https://github.com/Alishahryar1/free-claude-code/issues

For NVIDIA NIM issues:
- Visit: https://developer.nvidia.com/

## 🔒 Privacy

This installer:
- Does not collect any personal data
- Does not send information to external servers
- Only downloads necessary software from official sources
- Stores your NVIDIA NIM API Key locally on your computer
- Does not share your API Key with anyone

Your NVIDIA NIM API Key is stored in:
`%USERPROFILE%\claude-nvidia-proxy\.env`

This file is only accessible by your user account.

## 📄 License

This installer is provided as-is without warranty of any kind.

The original claude-nvidia-proxy project is licensed under the MIT License.

---

**Ready to get started? 🚀**

1. Get your API Key: https://build.nvidia.com/settings/api-keys
2. Run: Install-FreeClaudeCode.bat (as administrator)
3. Enjoy Claude Code for free!

# OpenCode CLI Installer for Windows 11

## ⚡ Quick Install (No Download Required)

### 🚀 Install with One Command

Copy and paste this command in PowerShell (Run as Administrator):

```powershell
irm https://raw.githubusercontent.com/Tutevinho/opencode-gemini-installer/main/Installer-OpenCodeCLI.ps1 | iex
```

### 🗑️ Uninstall with One Command

Copy and paste this command in PowerShell (Run as Administrator):

```powershell
irm https://raw.githubusercontent.com/Tutevinho/opencode-gemini-installer/main/Uninstaller-OpenCodeCLI.ps1 | iex
```

---

## 🚀 Quick Start

### 3 Simple Steps to Get Started:

1. **Get Your Free Google Gemini API Key**
   - Go to: https://aistudio.google.com/app/apikey
   - Sign in with your Google account
   - Create an API Key
   - The key will look like: `AIzaSyxxxxxxxxxxxx`

2. **Run the Installer**
   - Right-click on `Install-OpenCodeCLI.bat`
   - Select "Run as administrator"
   - Follow the graphical installer prompts
   - Paste your API Key when requested

3. **Start Using!**
   - Double-click on `OpenCodeCLI.bat` on your desktop
   - OpenCode CLI will launch automatically in your terminal

## 📦 What's Included

- **Install-OpenCodeCLI.bat** - Main installer launcher
- **Installer-OpenCodeCLI.ps1** - Graphical installation script
- **Uninstall-OpenCodeCLI.bat** - Uninstaller launcher
- **Uninstaller-OpenCodeCLI.ps1** - Graphical uninstallation script
- **README.md** - This file

## ⏱️ Installation Time

- If you already have Node.js: ~2-5 minutes
- If you need Node.js installed: ~10-15 minutes

**Note:** Node.js installation may take several minutes. Please be patient.

## 💡 System Requirements

- ✅ Windows 11 (recommended) or Windows 10
- ✅ 4 GB RAM minimum (8 GB recommended)
- ✅ Internet connection
- ✅ Administrator permissions

## 🔧 What Gets Installed

The installer will automatically set up:

1. **Node.js v22 LTS** - If not already installed
2. **OpenCode CLI** - Installed globally via npm (`opencode-ai`)
3. **GOOGLE_API_KEY** - Set as a permanent user environment variable
4. **OpenCodeCLI.bat** - Desktop shortcut for easy access

## 🗑️ Uninstallation

To uninstall:

1. Run `Uninstall-OpenCodeCLI.bat` as administrator
2. Confirm uninstallation
3. The binary and environment variables will be removed

## ⚠️ Troubleshooting

### "Cannot run installer"
- Run as administrator
- Verify all files are in the same folder

### "npm not found"
- The installer will install Node.js automatically. If it fails, download Node.js from: https://nodejs.org/en/download

### "Invalid API Key"
- Make sure it's a valid Google Gemini API Key from AI Studio
- Check for extra spaces

## 📚 Documentation

For more info on how to use OpenCode, visit:
**https://opencode.ai/docs**

## 🎮 What is OpenCode CLI?

OpenCode is the open source AI coding agent. It allows you to write code in your terminal with full context, LSP support, and multi-agent capabilities.

- ✅ Native support for Google Gemini, Claude, GPT, and local models
- ✅ Built-in LSP for better code understanding
- ✅ Open source and privacy-first
- ✅ High performance in the terminal

## 🙏 Credits

- OpenCode Team: https://github.com/anomalyco/opencode
- Google Gemini API for the powerful AI backend

## 📞 Support

For installation issues:
- Check the installation log for error messages
- Ensure you're running as administrator
- Verify internet connection

## 🔒 Privacy

This installer:
- Does not collect any personal data
- Only downloads necessary software from official sources
- Stores your Google API Key locally in your system environment variables
- Does not share your API Key with anyone

## 📄 License

This installer is provided as-is without warranty of any kind.

---

**Ready to get started? 🚀**

1. Get your API Key: https://aistudio.google.com/app/apikey
2. Run: Install-OpenCodeCLI.bat (as administrator)
3. Enjoy OpenCode CLI!

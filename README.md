# 🌐 Network Profile Configuration Tool

A powerful Windows batch script for effortlessly switching network adapter profiles between static IPs and DHCP. Features auto-elevation to administrator privileges and robust PowerShell fallbacks for maximum reliability.

## ✨ Features

| Feature                     | Description                                                  |
| --------------------------- | ------------------------------------------------------------ |
| 🔍 **Adapter Detection**    | Automatically detects and lists all enabled network adapters |
| 🎯 **Profile Selection**    | Choose from predefined profiles or reset to DHCP             |
| 🔧 **Static IP Setup**      | Quickly configure static IPs, gateways, and DNS servers      |
| 🔄 **DHCP Reset**           | Seamlessly reset adapters to obtain IP/DNS automatically     |
| 🛡️ **Auto-Elevation**       | Automatically requests administrator privileges if needed    |
| 🛠️ **Error Handling**       | Comprehensive error checking with color-coded messages       |
| 🔧 **PowerShell Fallbacks** | Uses PowerShell commands as backup for netsh failures        |
| 🧹 **Route Cleanup**        | Attempts to remove leftover default gateway routes           |

### 📋 Available Profiles

- **PC 1 Profile**: IP `192.168.0.1`, Gateway `192.168.0.2`
- **PC 2 Profile**: IP `192.168.0.2`, Gateway `192.168.0.1`
- **Reset to Default**: DHCP configuration with automatic DNS

## 🚀 Quick Start

### Prerequisites

- Windows 10/11 with PowerShell
- Administrator privileges (script auto-elevates)

### Usage

1. **Run** the script:

   ```cmd
   ip_config.bat
   ```

   The script will automatically elevate to administrator if needed.

2. **Select Adapter**: Choose your network adapter from the numbered list

3. **Choose Profile**:

   - Press `1` for PC 1 Profile
   - Press `2` for PC 2 Profile
   - Press `3` to reset to DHCP
   - Press `4` to return to adapter selection

4. **Confirmation**: Review the configuration status and press `R` to return to menu or any key to exit

## 📖 Example Output

```
============================================
    Choose Configuration Profile
============================================
 ----Selected Adapter: Ethernet----

 [1] PC 1 Profile - IP: 192.168.0.1 - Gateway: 192.168.0.2

 [2] PC 2 Profile - IP: 192.168.0.2 - Gateway: 192.168.0.1

 [3] Reset to Default (DHCP)

 [4] Return to Adapter Selection

============================================
Select profile (1-4):
```

**Made with ❤️ for network administrators and power users!**

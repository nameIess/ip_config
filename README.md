# Network Profile Configuration Tool 🖧

A Windows batch script for quickly switching network adapter profiles between static IPs and DHCP, with auto-elevation to administrator and PowerShell fallbacks for reliability.

## Features ✨

- Modern, boxed-style UI using box-drawing characters for menus and section headers
- Lists available network adapters for selection
- Choose from preset profiles:
  - **PC 1**: IP `192.168.0.1`, Gateway `192.168.0.2`
  - **PC 2**: IP `192.168.0.2`, Gateway `192.168.0.1`
  - **Reset to Default (DHCP)`**
- Sets DNS servers (OpenDNS) for static profiles
- Resets DNS and IP to DHCP with PowerShell fallback
- Attempts to remove leftover default gateway routes
- Color-coded output and error messages
- Auto-elevates to administrator if needed

## Usage 🚀

1. **Run** `ip_config.bat` as administrator (auto-elevates if not).
2. **Select** your network adapter from the visually enhanced menu.
3. **Choose** a profile from the boxed menu:
   - `1` for PC 1
   - `2` for PC 2
   - `3` to reset to DHCP
   - `4` to return to adapter selection
4. **Follow prompts** for status and errors. After each configuration, you can press `R` to return to the menu or any other key to exit.

## Known Issue ⚠️

- After resetting to DHCP, the script may display an error message even if the reset was successful. This is due to error handling logic that can trigger on PowerShell fallback, but the adapter is usually reset correctly. Always check the adapter configuration output for confirmation.

## License 📄

MIT License

---

Made with ❤️ for quick network switching!

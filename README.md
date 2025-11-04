# Network Profile Configuration Tool 🖧

A Windows batch script for quickly switching network adapter profiles between static IPs and DHCP, with auto-elevation to administrator and PowerShell fallbacks for reliability.

## Features ✨

- Clean, text-based UI with bordered sections for menus and headers
- Lists available network adapters for selection
- Choose from preset profiles:
  - **PC 1**: IP `192.168.0.1`, Gateway `192.168.0.2`
  - **PC 2**: IP `192.168.0.2`, Gateway `192.168.0.1`
  - **Reset to Default (DHCP)**
- Sets DNS servers (OpenDNS) for static profiles
- Resets DNS and IP to DHCP with robust error handling
- Attempts to remove leftover default gateway routes
- Color-coded output and error messages
- Auto-elevates to administrator if needed

## Usage 🚀

1. **Run** `ip_config.bat` as administrator (auto-elevates if not).
2. **Select** your network adapter from the menu.
3. **Choose** a profile from the menu:
   - `1` for PC 1
   - `2` for PC 2
   - `3` to reset to DHCP
   - `4` to return to adapter selection
4. **Follow prompts** for status and errors. After each configuration, you can press `R` to return to the menu or any other key to exit.

## License 📄

MIT License

---

Made with ❤️ for quick network switching!

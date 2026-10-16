# Zoey SOS

A reassuring 1-click self-heal, system rollback, and diagnostic companion built in c++20, Qt6, and KDE Frameworks 6 Kirigami for ZoeyOS.

## Features

- **1-Click Quick Fixes**:
  - **Fix Audio**: Restarts `pipewire` and `wireplumber` user services when sound cuts out.
  - **Fix Internet**: Cycles `NetworkManager` connections cleanly.
  - **Refresh Desktop**: Gracefully restarts `plasmashell` if the panel or desktop freezes without closing open apps.
- **Message Sho -- Diagnostic Snapshot**: Genereates a clean, formatted report of OS, kernel, uptime, free disk space, and audio status, and copies it to the clipboard in one click.
- **System Time Machine**: Lists Btrfs / Snapper snapshots and allows 1-click system rollback via `pkexec snapper rollback`.

## Building & Running

```bash
mkdir build && cd build
cmake .. -GNinja
ninja
./zoey-sos
```

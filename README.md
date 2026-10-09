# Vertix Client

## Testupdate 0.2.0

Verbesserte Instanzeinstellungen im bestehenden Vertix-Design, mit den Bereichen Allgemein und Installation, RAM-Slider (0,5-GB-Schritte), Schnellwerten und einer Installationsübersicht.

[Release und Downloads](https://github.com/LeonM1501/vertix-client/releases/tag/v0.2.0)

### Update aus der bisherigen Version 0.1.0 testen

1. Die bisherige Version bzw. das unveränderte bisherige Setup verwenden.
2. [Vertix-Updates-einrichten.cmd](releases/0.2.0/Vertix-Updates-einrichten.cmd) herunterladen und einmal ausführen. Die Hilfsdatei schreibt ausschließlich `%APPDATA%\vertix\update_release.json` und sichert eine vorhandene Konfiguration. Sie installiert nichts.
3. Vertix öffnen. Innerhalb von ungefähr 30 Sekunden erscheint das Update unten links; alternativ unter Über Vertix nach Updates suchen.
4. Das Update im Client herunterladen und anschließend installieren.

Die alte Version enthält eine falsche feste Updateadresse. Die einmalige Hilfsdatei ermöglicht den Übergang ohne Austausch des alten Setups oder der installierten Programmdateien. Ab Version 0.2.0 wird die richtige Updateadresse direkt abgefragt. Für Updates muss kein eigener Server laufen: GitHub stellt Metadaten und Downloads bereit.

### Dateien und Quellcode

- [Windows-Installer 0.2.0](releases/0.2.0/Vertix-Client-Setup.exe)
- [Vollständiger entsprechender Quellcode](releases/0.2.0/Vertix-Client-0.2.0-source.tar.gz)
- [Update-Metadaten und SHA-256-Prüfsummen](version.json)
- [GPL-3.0-Lizenz](LICENSE) und [Drittanbieterhinweise](NOTICE.md)

Der Installer enthält WebView2Loader.dll und die benötigte x64-libunwind.dll. Download und Installation werden durch den Benutzer ausgelöst.

### Lokalen Release bauen

Nach Installation der Node-Abhängigkeiten und der Rust-Toolchain `stable-x86_64-pc-windows-gnullvm`:

```powershell
$env:RUSTUP_TOOLCHAIN = 'stable-x86_64-pc-windows-gnullvm'
.\build-release.ps1 -ArtifactDirectory '.\artifacts\releases\0.2.0'
Copy-Item .\artifacts\WebView2Loader.dll .\artifacts\releases\0.2.0\
makensis /DARTIFACT_DIR=artifacts\releases\0.2.0 /DAPP_VERSION=0.2.0 installer.nsi
```

Die WebView2Loader.dll muss aus dem Microsoft WebView2 SDK bereitgestellt werden. Frontend-Assets werden für den nativen Release eingebettet; ein Entwicklungsserver ist nicht erforderlich.

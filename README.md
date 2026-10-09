# Vertix Client

## Version 0.4.0

Fünf auswählbare Oberflächen: **Mono**, **Papier**, **Terminal**, **Galerie** und **Fokus**. Sie verändern Navigation, Bibliothek, Spielbereich und Inhaltsansichten. Unter **Einstellungen → Deine Oberfläche** lassen sich außerdem Schriftgröße, Abstände und Ecken anpassen.

Beim Öffnen einer Instanz prüft Vertix automatisch die bekannten Modrinth-Mods. **Alle aktualisieren** erscheint nur bei tatsächlich neueren kompatiblen Versionen. Minecraft-Version, Modloader und Veröffentlichungsdatum werden berücksichtigt; lokale Mods ohne Updatequelle werden ausgelassen. Fehlgeschlagene Prüfungen können wiederholt werden.

[Release und Downloads](https://github.com/LeonM1501/vertix-client/releases/tag/v0.4.0)

### Installieren und aktualisieren

- Bestehender Client ab 0.2.0: Update in Vertix herunterladen und anschließend installieren. Vertix beendet sich, aktualisiert seine Programmdateien ohne Setup-Assistent und startet automatisch neu.
- Neue Installation: Windows-Setup herunterladen und normal installieren. Die Updatequelle ist bereits enthalten; keine CMD-Hilfsdatei erforderlich.
- Historische 0.1.0-Installationen ohne die eingerichtete Updatequelle benötigen den früheren einmaligen Übergang oder eine aktuelle Setup-Datei. Das nachträglich vorbereitete Desktop-Setup richtet die Quelle bereits selbst ein.

GitHub stellt Metadaten und Downloads bereit; ein eigener Update-Server ist nicht erforderlich. Profil- und Spieldaten werden bei einem Client-Update nicht deinstalliert.

### Weitere Funktionen

Minecraft-Version, Modloader und konkrete Modloader-Version beim Erstellen einer Instanz oder in den Instanzeinstellungen wählen. Ohne feste Modloader-Version wird die neueste kompatible Version verwendet. Vor einem Wechsel bestehende Welten sichern und Mods auf Kompatibilität prüfen.

Globaler Modkatalog mit optionalen Versions-/Loaderfiltern und Auswahl einer kompatiblen Zielinstanz. Ressourcenpakete, Datenpakete und Shader bleiben über den Inhaltsbrowser der jeweiligen Instanz verfügbar.

### Dateien und Quellcode

- [Windows-Installer 0.4.0](releases/0.4.0/Vertix-Client-Setup.exe)
- [Vollständiger entsprechender Quellcode](releases/0.4.0/Vertix-Client-0.4.0-source.tar.gz)
- [Update-Metadaten und SHA-256-Prüfsummen](version.json)
- [GPL-3.0-Lizenz](LICENSE) und [Drittanbieterhinweise](NOTICE.md)

Der Installer enthält WebView2Loader.dll und die benötigte x64-libunwind.dll. Der Client basiert auf dem NoRiskClient-Launcher; entsprechende Lizenz- und Drittanbieterhinweise bleiben enthalten.

### Lokalen Release bauen

Nach Installation der Node-Abhängigkeiten und der Rust-Toolchain `stable-x86_64-pc-windows-gnullvm`:

```powershell
$env:RUSTUP_TOOLCHAIN = 'stable-x86_64-pc-windows-gnullvm'
.\build-release.ps1 -ArtifactDirectory '.\artifacts\releases\0.4.0'
Copy-Item .\artifacts\WebView2Loader.dll .\artifacts\releases\0.4.0\
makensis /DARTIFACT_DIR=artifacts\releases\0.4.0 /DAPP_VERSION=0.4.0 installer.nsi
```

Die WebView2Loader.dll muss aus dem Microsoft WebView2 SDK bereitgestellt werden. Frontend-Assets werden für den nativen Release eingebettet; ein Entwicklungsserver ist nicht erforderlich.

# Vertix Client

Eigenständiger Minecraft-Java-Profilmanager auf Basis des vollständig kopierten NoRiskClient-Launcher-Quellcodes 0.6.28. Vertix-Änderungen vom 9. Oktober 2026. GNU GPLv3; siehe [LICENSE](LICENSE) und [NOTICE.md](NOTICE.md).

## Version 0.5.0

Marvins OLED-Oberfläche ergänzt die fünf bisherigen Designs: schwarzer Hintergrund, eine frei wählbare Akzentfarbe, eine vereinfachte Navigation und eine Startseite mit Instanzübersicht. Bestehende Darstellungsoptionen aus 0.4.0 werden übernommen; OLED lässt sich unter Einstellungen auswählen.

Beim Erstellen und Bearbeiten einer Instanz zeigt Vertix eine RAM-Empfehlung aus dem gesamten Systemspeicher und der Modanzahl an. „Übernehmen“ setzt den vorgeschlagenen Wert im RAM-Regler. Die drei Entdecken-Kacheln öffnen Mods, Shader beziehungsweise Ressourcenpakete. Jeder Katalog bietet Versionsfilter, Instanzauswahl und eine Prüfung auf eine passende Veröffentlichung; Shader benötigen weiterhin Iris oder OptiFine.

Validierung: `node scripts/test-appearance-ram.cjs`, `node scripts/test-content-compatibility.cjs`, `node scripts/test-mod-updates.cjs`, TypeScript-Prüfung und Produktionsbuild. Release bauen: `./build-release.ps1 -ArtifactDirectory ./artifacts/releases/0.5.0`, `WebView2Loader.dll` bereitstellen und NSIS mit `/DARTIFACT_DIR=artifacts\releases\0.5.0 /DAPP_VERSION=0.5.0 installer.nsi` kompilieren.

## Version 0.4.0

Fünf wählbare Oberflächen unter Einstellungen: Mono (Seitenleiste), Papier (helle Bibliothek mit Navigation rechts), Terminal (obere Navigation und kompakte Listen), Galerie (Symbolnavigation und Karten) und Fokus (zentraler Spielbereich, untere Navigation). Auch Instanz-, Bibliotheks- und Katalogansichten folgen dem gewählten Layout. Alle verwenden eine zusammenhängende neutrale Palette ohne Glow, Schatten oder dekorative Hintergründe. Schriftgröße, Abstände und Ecken lassen sich separat einstellen; die Auswahl bleibt lokal gespeichert.

Beim Öffnen einer Instanz werden Modrinth-Mods automatisch auf neuere kompatible Veröffentlichungen geprüft. „Alle aktualisieren“ und die einzelnen Mod-Updateknöpfe erscheinen nur bei tatsächlich gefundenen Updates. Die Prüfung berücksichtigt Loader, Minecraft-Version, Veröffentlichungsdatum und bekannte installierte Versions-ID. Lokale Mods ohne Updatequelle werden ausgelassen; fehlgeschlagene Prüfungen werden angezeigt und können wiederholt werden. Aktualisiert wird genau die geprüfte Veröffentlichung; eine ältere Release-Datei ersetzt keine neuere Beta.

Prüfungen: `node scripts/test-content-compatibility.cjs`, `node scripts/test-mod-updates.cjs`, TypeScript-Prüfung, Produktionsbuild, visuelle Prüfung aller fünf Oberflächen sowie ein isolierter UI-Test mit Beispieldaten für das Ein-/Ausblenden des Sammelbuttons. Die lokale Installation und die Desktop-Setup-Datei werden zum Bauen und Veröffentlichen nicht verändert.

Release bauen: `./build-release.ps1 -ArtifactDirectory ./artifacts/releases/0.4.0`; `WebView2Loader.dll` mit bereitstellen und NSIS mit `/DARTIFACT_DIR=artifacts\releases\0.4.0 /DAPP_VERSION=0.4.0 installer.nsi` kompilieren.

## Version 0.3.0

Updates werden nach dem Download ohne Setup-Assistent angewendet; Vertix startet anschließend automatisch neu. Der Übergang von 0.2.0 erkennt den bisherigen Update-Downloadordner. Bei einer eigenständig geöffneten Setup-Datei bleibt die normale Installation verfügbar.

Minecraft-Version, Modloader und eine konkrete Modloader-Version können bei der Erstellung und in den Instanzeinstellungen gewählt werden. Ohne feste Modloader-Version wird die neueste kompatible Version verwendet. Vor einem Wechsel vorhandene Welten sichern und die Kompatibilität vorhandener Mods prüfen.

Der globale Modkatalog startet ohne Instanzbindung. Optional nach Modloader und Minecraft-Version filtern, dann eine kompatible Zielinstanz auswählen. Ressourcenpakete, Datenpakete und Shader bleiben im instanzbezogenen Inhaltsbrowser verfügbar.

Release bauen: `./build-release.ps1 -ArtifactDirectory ./artifacts/releases/0.3.0`; `WebView2Loader.dll` dort mit bereitstellen und NSIS mit `/DARTIFACT_DIR=artifacts\releases\0.3.0 /DAPP_VERSION=0.3.0 installer.nsi` kompilieren. Der Build benötigt das Feature `custom-protocol`; alle mitgelieferten Runtime-DLLs gehören zum Setup.

## Funktionsumfang

- Eigene Vertix-Oberfläche in Schwarz und Graphit, eigenes SVG-Logo und selbst erstellte Landschaft; keine übernommenen Markenbilder oder Hintergründe in der Anwendung.
- Leere Profilbibliothek beim ersten Start. Eigene Profile mit Minecraft-Version, Vanilla/Fabric/Forge/NeoForge/Quilt und RAM-Einstellung.
- Instanzseite mit Inhaltsliste, Versionen, Aktivierung, Updates und Entfernen sowie Ansichten für Dateien, Welten und Protokolle.
- Modrinth-Browser für Mods, Ressourcenpakete, Datenpakete und Shader: Suche, Kategorien, Sortierung und Ergebnisseiten. Mod-Version und Modloader passen zur Instanz; erforderliche Mod-Abhängigkeiten werden berücksichtigt.
- Lokale JAR-Dateien importieren und Profilordner öffnen. Verwaltete Mods werden bei der Profilvorbereitung heruntergeladen und in den normalen `mods`-Ordner des Profils kopiert. Es wird kein NoRisk-Forge-Helfer geladen.
- **Eigene Microsoft-Anmeldung:** Vertix verwendet die am 9. Oktober 2026 registrierte öffentliche Desktop-App `308cbf7a-f013-46c9-b015-8f45ef804a7f`. Anmeldung im Systembrowser über OAuth mit PKCE; ein kurzlebiger Empfänger bindet nur an den lokalen Rechner. Windows schützt die gespeicherte Sitzung mit DPAPI. Minecraft-Profil und Java-Spielberechtigung werden vor dem Start online geprüft. Ob Minecraft diese neue App akzeptiert, ist noch durch eine echte Anmeldung zu bestätigen; ggf. ist eine App-Freigabe durch Mojang/Microsoft erforderlich. Der offizielle Launcher bleibt als Ausweichweg verfügbar.
- Eigene App-Kennung `app.vertix.client` und eigener Datenordner. Es werden keine bestehenden NoRisk-Konten oder Profile eingelesen.
- Kein Newsfeed, Werbung, Shop, Capes, Freunde, Events, Clips, Flagsmith-Frontend, Telemetrie oder Upstream-Update-Download im Vertix-Programmstart. Die alten Dienste sind nicht als Desktop-Befehle registriert. Der alte HTTP-Servicekanal ist zusätzlich abgeschaltet.

Eigene gebündelte Vertix-Profile und eigene entwickelte Mods sind noch nicht enthalten, wie für diesen ersten Schritt vorgesehen.

## Starten

Falls vorhanden, `artifacts/Vertix Client.exe` öffnen. Das ist ein lokaler Windows-Testbuild mit eingebetteter Oberfläche, kein signierter öffentlicher Release. WebView2 wird benötigt.

Alternativ in PowerShell:

```powershell
$env:PATH = "$env:USERPROFILE\.cargo\bin;$env:PATH"
npm install
npm run desktop
```

Eigene Anmeldung: oben rechts **Bei Minecraft anmelden** → **Mit Microsoft anmelden**. Danach eine Instanz auswählen und starten. Ohne eigene Sitzung bietet Vertix weiterhin den offiziellen Launcher als Alternative.

Voraussetzungen für die Entwicklung: Node.js, Rust mit MSVC-Toolchain, Visual Studio C++ Build Tools, WebView2. `Start-Vertix.ps1` verwendet den vorhandenen Testbuild oder startet die Entwicklungsversion.

```powershell
npm run dev             # Designvorschau unter http://127.0.0.1:1430
npm run build           # TypeScript + Produktionsoberfläche
npm run desktop:build   # Windows-Installer; Release-Build
```

Die Browser-Vorschau verwendet einen eigenen lokalen Vorschauspeicher. Anmeldung, Dateioperationen und Minecraft-Start sind ausschließlich in der Desktop-App verfügbar. Sie werden in der Vorschau nicht vorgetäuscht.

## Anmeldung und Spielstart

Oben rechts **Bei Minecraft anmelden** wählen und die Anmeldung im Browser abschließen. Danach eine Instanz erstellen, Inhalte hinzufügen und **Spielen** wählen. Vor dem Spielstart werden Konto und Java-Spielberechtigung geprüft. Die neue App-Registrierung ist erstellt; ein echter Minecraft-Login und Spielstart mit ihr sind noch nicht bestätigt.

### Alternative über den offiziellen Launcher

1. Den [offiziellen Minecraft Launcher](https://www.minecraft.net/download) installieren.
2. Dort mit einem Konto anmelden, das Minecraft: Java Edition besitzt. In Vertix unter Einstellungen **Erneut prüfen** wählen.
3. Eine Instanz erstellen, öffnen und unter **Inhalte entdecken** Mods oder Pakete hinzufügen. **Spielen** verwendet den Direktstart, sofern eine gültige Minecraft-Spielsitzung lokal vorliegt.
4. Fehlt eine solche Sitzung, zeigt Vertix das ausdrücklich an. Den offiziellen Launcher schließen und **Installation vorbereiten** wählen. Anschließend im offiziellen Launcher die Installation **Vertix · Profilname** auswählen und dort spielen. Bei Modloadern den Filter **Modifiziert** einschalten.
5. Nach Änderungen den Export bei Bedarf wiederholen. Der Spielordner bleibt pro Instanz getrennt.

Vertix erkennt klassische Windows-Installationen sowie das Microsoft-Store-Paket, einschließlich der Variante mit GameLaunchHelper.exe. Andere Installationspfade lassen sich unter Einstellungen auswählen. Beim Export muss der offizielle Launcher geschlossen sein, damit er die Installationsliste nicht überschreibt. Bestehende Installationen bleiben erhalten; vor Änderungen wird eine Sicherung erstellt.

**Grenze des offiziellen Ausweichwegs:** Das lokale Accountformat ist keine zugesicherte öffentliche Schnittstelle. Der hier installierte Store-Launcher stellt trotz angemeldetem Konto und erfolgtem Java-Start keine wiederverwendbare Spielsitzung in seiner Accountdatei bereit. Deshalb konnte der Direktstart über dessen gespeicherte Sitzung auf diesem Rechner nicht bestätigt werden. Die neue eigene Vertix-Anmeldung wird davon unabhängig verwendet. Erneutes Anmelden wird nicht als sichere Lösung versprochen. Vertix umgeht weder Anmeldung noch Spielberechtigung. Es verwendet keine fremde OAuth-App-ID und liest keine Microsoft-Refresh-Anmeldedaten oder verschlüsselten Credential-Dateien des offiziellen Launchers aus. Eine vorhandene Minecraft-Spielsitzung wird ausschließlich im Arbeitsspeicher verwendet und nicht in Vertix gespeichert oder an die Oberfläche gegeben. Nach Ablauf muss der offizielle Launcher eine neue Sitzung bereitstellen.

Jedes Profil verwendet einen eigenen Spielordner für Welten, Mods, Konfigurationen, Einstellungen, Serverlisten, Ressourcenpakete, Shader und Screenshots. Vertix-Daten liegen standardmäßig unter `%APPDATA%\vertix\VertixClient`; die Instanzen darunter in `data/profiles`. Technische Download-Caches für Bibliotheken, Assets und Mod-Dateien können gemeinsam genutzt werden. Welten und Einstellungen werden weder geteilt noch aus Standardordnern importiert. Das Entfernen eines Profils entfernt keine bereits exportierte Installation aus dem offiziellen Launcher; diese kann dort manuell entfernt werden.

Datenpakete werden unter `saves/<Welt>/datapacks` installiert. Dafür muss eine Welt in dieser Instanz existieren; eine laufende Welt benötigt danach einen Neustart oder `/reload`. Shaderpakete benötigen einen Shaderloader wie Iris oder OptiFine, der nicht automatisch mit dem Paket installiert wird. Ressourcen- und Shaderpakete werden anschließend in Minecraft ausgewählt. Deaktivierte lokale Inhalte erhalten die Endung `.disabled`; deaktivierte verwaltete Mods werden aus dem aktiven Mods-Ordner entfernt.

Vanilla-, Fabric- und Quilt-Versionen werden aus offiziellen Metadaten vorbereitet. Forge und NeoForge verwenden ihren offiziellen Client-Installer in einem separaten Zwischenordner. Beim Exportweg lädt der offizielle Launcher fehlende Minecraft-Dateien. Beim bedingten Direktstart übernimmt Vertix Downloads sowie die Online-Prüfung von Profil und Spielberechtigung. Vollständige Spielstarts sind noch nicht für alle Loader bestätigt.

Die aktive Anmeldung befindet sich in `src-tauri/src/vertix_auth.rs`. Historischer Upstream-Anmeldecode bleibt inaktiv als Quellreferenz erhalten. Die Oberfläche erhält nur Spielername und Anmeldestatus, keine Tokens. Abmelden entfernt ausschließlich Vertix’ eigene gespeicherte Sitzung.

### Microsoft-App und Weitergabe

Die öffentliche Client-ID ist im Build enthalten und kein Geheimnis. Andere Nutzer müssen keine Azure-App anlegen: Sie melden sich mit ihrem eigenen Microsoft-Konto und eigener Minecraft-Java-Spielberechtigung an. `http://localhost:25585/callback` ist als öffentlicher Desktop-Redirect registriert. Der Empfänger läuft nur während der Anmeldung auf dem jeweiligen Nutzer-PC; Vertix wählt einen freien Port, den Microsoft bei localhost-Weiterleitungen ignoriert. Der Pfad `/callback` bleibt gleich. Es ist kein gehosteter Callback-Server und kein Client-Secret erforderlich.

Für diese Einrichtung wurden ausschließlich die App-Registrierung und ein öffentlicher Redirect angelegt. Keine kostenpflichtigen Azure-Compute-, Hosting- oder Speicherressourcen und kein Pay-as-you-go-Upgrade wurden durch Codex aktiviert. App-Registrierung und bestätigter Minecraft-Zugang sind getrennte Schritte; eine erfolgreiche Registrierung beweist keine Freigabe durch Minecraft.

Microsoft-Dokumentation: https://learn.microsoft.com/en-us/entra/identity-platform/reply-url#localhost-exceptions

## Herkunft und Veröffentlichung

Die alte Oberfläche und die Originalgrafiken befinden sich zur Referenz in `upstream/` und werden nicht in das Frontend-Bundle kopiert. Im Rust-Quellcode bleiben interne Kompatibilitätstypen und derzeit nicht verwendete Upstream-Module erhalten; dies ist keine vollständige Entfernung sämtlicher historischer Bezeichner. Lizenz- und Herkunftshinweise bleiben absichtlich erhalten, auch im Dialog **Über Vertix**.

Vertix bleibt ein GPLv3-Fork. Beim Verteilen eines Binaries muss der zu dieser Version gehörende vollständige korrespondierende Quellcode GPL-konform verfügbar sein; Copyright- und Lizenzhinweise müssen erhalten bleiben. Eigenes Branding hebt diese Verpflichtung nicht auf. Die Verfügbarkeit des Namens Vertix als Marke wurde nicht geprüft. Es gibt keine pauschale Zusicherung rechtlicher Problemfreiheit.

Referenz: [GNU GPLv3, insbesondere Abschnitte 4–6](https://www.gnu.org/licenses/gpl-3.0.html).

## Projektstruktur

- `src/`: aktive, eigene React-Oberfläche und Tauri-Anbindung.
- `public/`: ausschließlich Vertix-Logo und Lizenztext für die Oberfläche.
- `src-tauri/`: übernommene Minecraft-/Modloader-Grundlage, Vertix-Programmstart und Übergabe an den offiziellen Launcher.
- `upstream/`: ursprüngliche Oberfläche, Assets, Einstiegspunkte und Release-Konfiguration als Referenz.
- `scripts/prepare-vertix.mjs`, `scripts/finish-vertix.mjs`: einmalige Migrationsskripte; **nicht erneut auf dem bereits angepassten Projekt ausführen**.

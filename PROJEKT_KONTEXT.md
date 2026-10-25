# Vertix: Projektkontext und Übergabe

## Aktueller Auftrag und Übergabe: 0.13.0 (25.10.2026)

Der Nutzer hat ausdrücklich das Update und einen aktualisierten Chat-/Projektkontext
auf GitHub und dem USB-Stick angefordert. Version 0.13.0 enthält Multi-Account und
die Skin-Startseite, Core bleibt 1.6.0. Öffentliche Updatequelle ist ausschließlich
https://raw.githubusercontent.com/LeonM1501/vertix-client/main/version.json.
Private normale Source-Repo: https://github.com/LeonM1501/vertix-client-source.
Öffentliche Releases: https://github.com/LeonM1501/vertix-client/releases.

Wie bisher schneller Windows-Testbuild (Dev-Profil, custom-protocol, eingebettete
Produktionsoberfläche), kein optimierter Release-Build. Der Nutzer hatte auf den
langen Windows-Release-Build ausdrücklich verzichtet. Neuer Build, passender
Installer und vollständiger korrespondierender Source werden gemeinsam mit SHA256
veröffentlicht; niemals ein neues Manifest auf einen alten Installer zeigen lassen.
Der Update-Installer wird vom Client still gestartet und startet Vertix danach neu.
Die persönliche Installation und das Desktop-Setup nicht manuell ersetzen.

USB ist E: (WIIU_USB, FAT32). Dort liegt eine ältere Source-Arbeitskopie mit eigenen
Commits; diese beim Kontext-Kopieren nicht resetten oder überschreiben. Nur den
Kontext aktualisieren. Die archivierte 26.2-Instanz und alle anderen USB-Projekte
unverändert lassen. Der aktuelle Source liegt in der normalen GitHub-Source-Repo.

Nutzerwünsche: Deutsch, direkt arbeiten, unnötige Rückfragen vermeiden. Matte graue
und schwarze Oberfläche ohne Glow, eigenes Vertix-Design. Gespeicherte Designs
nicht überschreiben. Mehrere Microsoft-Anmeldungen erhalten; Auswahl gilt für den
nächsten Spielstart. Eigener Skin zentral, Instanzwahl neben Spielen, Direktstart
aus der Bibliothek. Nicht zugehörige Loader/Game-Versionen nicht als unterstützt
behaupten. Aktuelle Core-Ziele: Fabric 26.2/26.3 und Forge 1.20.1.

Prüfgrenzen: echter Skin-Abruf im angemeldeten nativen Client und zweites echtes
Microsoft-Login sowie vollständiger Spielstart nach diesem UI-Update sind noch
nicht praktisch geprüft. Bestehende accounts.json ist unverschlüsselt; keine
Tokens, API-Keys oder Kontodateien in Kontext, Source-Archiv oder Releases aufnehmen.
CurseForge-Keys bleiben pro PC DPAPI-verschlüsselt. Keine Schlüssel hier abdrucken.

## Bestandteil von 0.13.0: Skin-Startseite und grauschwarzes Standarddesign

Home.tsx zeigt jetzt den eigenen Skin zentral, einen geteilten Spielen-Button mit
Instanz-Dropdown und rechts die letzten Instanzen plus Inhaltsverknüpfungen.
Die Auswahl bleibt über den vorhandenen selectedId-Pfad gespeichert. Der untere
zusätzliche Startbalken wird nur auf der Startseite ausgeblendet. Bibliothekskarten
haben einen direkten Spielen-Button; launch(profile) verwendet ausdrücklich die
angeklickte Instanz, nicht einen möglicherweise noch alten React-Auswahlzustand.
Slate ist neuer Standard mit neutralem Akzent; gespeicherte Designwünsche bleiben
erhalten. Die Sidebar verwendet matte grauschwarze Flächen und klare Icon-Buttons.

SkinPreview rendert lokal sechs 3D-Körperteile mit beiden Texturebenen, Drehregler,
Classic-/Slim-Modell und gespiegelten Armen/Beinen bei alten 64x32-Skins. Keine neue
Abhängigkeit und kein fremder Skin-Renderdienst. get_vertix_skin ist in main.rs
registriert, akzeptiert nur eine gespeicherte Konto-ID und liefert nur Textur und
Modell, keine Tokens. Vorhandener aktiver Skin-Cache und Mojang-Abruf werden genutzt;
Timeout 20 Sekunden, Größenlimit 2 MiB Base64, Standard-Steve bei Netzwerkfehlern.
Der lokale Standardskin stammt unverändert aus Minecraft 26.2; Asset-Hinweis liegt
unter public/skins/README.md. UI-Vorschau hat keine echte Anmeldung.

Tests: scripts/test-home.cjs (Skin-UVs/Layer/Legacy, Fallback, Dropdown/Leerzustand/
Startfortschritt), test-appearance-ram.cjs (neuer Standard und Erhalt gespeicherter
Wünsche), test-upgrade-ui.cjs, Frontend-Build und nativer custom-protocol-Check.
Browserprüfungen/Screenshots liegen unter artifacts/home-preview. Der Nutzer hat
die Veröffentlichung als Update angefordert; keine installierten Programmdateien
oder Welten werden beim Veröffentlichen direkt verändert.

## Bestandteil von 0.13.0: mehrere Microsoft-Konten

AccountMenu.tsx ersetzt den oberen Account-Button durch Kontoliste, Plus-Aktion
und ein Entfernen-Menü je Konto. Hinzufügen verwendet den vorhandenen
Microsoft-Anmeldedialog; gespeicherte Konten bleiben erhalten. Auswahl gilt für
den nächsten Spielstart, Entfernen betrifft keine Instanzen oder Welten.
Die vorhandene MinecraftAuthStore-Liste und aktives Konto werden wiederverwendet.
get_vertix_account liefert zusätzlich account_id und sichere Kontozusammenfassungen
ohne Tokens; select_vertix_account/remove_vertix_account sind in main registriert.
Eine ungültige Auswahl-ID deaktiviert keine vorhandenen Konten mehr.

Geprüft: Frontend-Build, nativer Binär-Check, persistentes Hinzufügen/Umschalten/
Entfernen/Neuladen mit Testkonten, Status-Serialisierung ohne Tokens, Browser-
Wechsel/Entfernen/Leerzustand/Plus, Enter/Escape/Fokus und Anmeldedialog-Integration.
Echte Anmeldung mit zweitem Microsoft-Konto nicht durchgeführt. Die bestehende
accounts.json speichert Tokens weiterhin unverschlüsselt; keine Formatmigration
und keine echte Kontoablage während der Tests verändert. Vorschau/Logs liegen in
artifacts/multi-account. Zusammen mit der neuen Startseite in Version 0.13.0.
Die anschließend gewünschte neue Startseite ist im Abschnitt oben beschrieben.

## Veröffentlicht: 0.12.0 / Core 1.6.0 – Testbuild

Release: https://github.com/LeonM1501/vertix-client/releases/tag/v0.12.0.
Öffentlicher Commit 8959b0bd9d73458662190d276dcf7bb60210bf07;
korrespondierender Source-Snapshot 8726a23ed3118398f38b2198bd7f8bcc111e92ef.
Workflow 39986254818 erfolgreich; beide vollständigen öffentlichen Downloads und
GitHub-Asset-Digests gegen SHA256 bestätigt. Der normale main/version.json-Kanal
lieferte nach kurzer CDN-Verzögerung ebenfalls 0.12.0. Testbuild mit
custom-protocol erfolgreich (6m52s); Debug-Symbole nur aus der Artefaktkopie
entfernt, NSIS-Installer gepackt. Alle drei Core-1.6.0-JARs im EXE nachgewiesen,
Common-Controls-v6-Anwendungsmanifest und Runtime-DLLs geprüft. Installer
25.028.515 Bytes, Source-Archiv 4.748.847 Bytes. Keine Zugangsdaten in EXE,
Installer oder Source-Archiv gefunden. Persönliche Installation, Profile, Welten
und Desktop-Setup wurden nicht ersetzt; kein lokaler Update-Trigger nötig.

SHA256 Installer: d388fd282913af803111c6a1fe1ab67e3dd518931a9df8a59e9b577f23dfcc3e.
SHA256 Source: 1f678d507f39ef62b8e1d6978331a8697742a4d719bdd005b083fc59c110096a.
Prüfbelege unter artifacts/verification/release-0.12.0 und
artifacts/releases/0.12.0. Das veröffentlichte Source-Archiv bleibt beim genannten
Snapshot; nachträgliche Übergabenotizen ändern seinen Hash nicht.

## Zur Veröffentlichung freigegeben: 0.12.0 / Core 1.6.0

Der Nutzer hat nach dem geprüften Entwicklungsstand ausdrücklich „Mach Update“
angefordert. Versionen in package/Cargo/Tauri auf 0.12.0, Changelog 0.12.0.
Auslieferung wie zuvor als schneller Dev-Profil-Testbuild mit custom-protocol und
eingebetteter Produktionsoberfläche. Der frühere Verzicht auf die optimierte
Windows-Release-Kompilierung bleibt berücksichtigt. Installer und vollständigen
korrespondierenden Source mit SHA256 über das bestehende öffentliche Manifest und
die vorhandene GitHub-Release-Pipeline veröffentlichen. Persönliche Installation,
Profile, Welten und Desktop-Setup nicht direkt ersetzen.

## Neuer Entwicklungsstand: Synchronisierung / Duplikate / Core 1.6.0

Nutzerauftrag: neuere doppelte Mods automatisch wählen; Standard-Minecraft-Tasten
und Grafik/UI gemeinsam synchronisieren, Mod-Tasten dagegen getrennt je Loader;
Ausnahmen je Instanz. Mit „VynNet“ war die Vertix-Ingame-Mod gemeint. Auf Nachfrage
hat der Nutzer den Port zunächst auf seine vorhandenen Instanzen begrenzt:
Fabric 26.2/26.3 und Forge 1.20.1 (AbyssMC, Forge 47.4.20).

Implementierung und Bedienung: `changelogs/settings-sync-and-forge.md`.
`options_sync.rs` enthält die selektive options.txt-Zusammenführung samt Sicherung
und Datenversionsstempel bei neuen Dateien; `settings_sync.rs` Vorlagenwahl,
persistente Snapshots und Instanzausnahmen. Erfassung beim Prozessende, Übernahme
vor dem Start; laufende Zielinstanzen bleiben bis zum nächsten Start unverändert.
`SettingsSync.tsx` ist in globalen und individuellen Einstellungen erreichbar.

`duplicate_mods.rs` prüft eingebettete IDs und semantische Versionen vor dem
Spielstart. Ältere Dateien werden unter mods/.vertix-duplicates gesichert;
uneindeutige Konflikte werden erklärt. Keine Auswahl allein anhand von Namen.
Deaktivierte Dateien und der Schutz lokaler Dateien bleiben erhalten.

Core 1.6.0 enthält die bisherigen beiden Fabric-Artefakte plus einen echten,
reobfuskierten Forge-1.20.1-Port. Gemeinsame Modulquellen werden über
`vertix-core-mod/forge-1.20.1/generate_sources.py` adaptiert. Das Gradle-Projekt
benötigt ein vollständiges Java-17-JDK, keine reine JRE. `build-port.ps1` baut und
kopiert die distributierbare JAR in die Launcher-Ressourcen. Smoke-Code ist nur
mit -Psmoke enthalten und darf nicht in eine Veröffentlichung gelangen.

Prüfung: Frontend-Build; 27 portable Datei-/Core-Tests; native Vorlagenauswahl mit
`--features test-manifest`. Forge-47.4.20-Entwicklungslauftest bestätigt 16 Module,
R-Shift-Öffnen ohne überlagernden Screen, Menü/HUD-Vorschau und Speichern von
Config/Keybinds. Keine persönliche Welt gestartet. Gameplay jedes einzelnen Moduls
in einer Welt ist noch nicht geprüft. Endgültige Forge-JAR enthält Refmap und
keine Smoke-Klasse; SHA256 f5a2ac98e51c7b81ed8a30b21a42799187323a60a605d09032fe9a53d420c8da.

Noch kein neuer Launcher-Release für diese Erweiterung: package/Cargo/Tauri und
version.json bleiben beim veröffentlichten 0.11.0-Stand. Persönliche Installation
und Desktop-Setup wurden nicht ersetzt. Keine erneute optimierte Windows-Release-
Kompilierung starten, solange der Nutzer seinen vorherigen Verzicht nicht ändert.

Windows-Testhinweis: Das vorhandene Merkmal test-manifest aktiviert Common
Controls v6. Ohne dieses Merkmal schlägt der volle native Testprozess vor den Tests
mit STATUS_ENTRYPOINT_NOT_FOUND für TaskDialogIndirect fehl. Loader-Snaps am
isolierten Testprozess bestätigten das; das Launcher-Programm hat sein eigenes
Tauri-Manifest. Keine Windows-System- oder Sicherheitskonfiguration wurde verändert.

## Veröffentlicht: 0.11.0 / Core 1.5.0 – Testbuild

Release: https://github.com/LeonM1501/vertix-client/releases/tag/v0.11.0. Öffentlicher Commit 49ed5215486e5c2a1317ef011a4af808e699cb8f; korrespondierender Source-Snapshot 42e2b1c2596a6a4dec1f87d363ffe7452264a24a. Workflow 39839176296 erfolgreich. Beide Downloads erneut öffentlich geladen und ihre SHA-256-Werte sowie die GitHub-Asset-Digests bestätigt. Dev-Profil mit custom-protocol erfolgreich (4m33s), anschließend nur Debug-Symbole entfernt und NSIS gepackt. Beide Core-JARs 1.5.0 im EXE nachgewiesen, DLL-Imports geprüft, benötigte Runtime-DLLs beigepackt. Dieser Testbuild ist bewusst nicht der optimierte Release-Build; ein späterer optimierter Ersatz benötigt eine höhere Version, etwa 0.11.1. Persönliche Client-EXE weiterhin 0.10.1 und unverändert. Für die sofortige Anzeige wurde nur vorübergehend das gültige öffentliche Manifest als lokaler Update-Trigger gesetzt; die normale Adresse lieferte unmittelbar nach Veröffentlichung noch gecachtes 0.10.1.

Veröffentlichung ausdrücklich bestätigt. Anschließend hat der Nutzer die optimierte Windows-Kompilierung abgewählt: schneller Testbuild mit custom-protocol und Produktionsoberfläche, unverändertes Core 1.5.0. Nie einen neuen Versionshinweis mit altem Setup verknüpfen.

Import: pack_archive.rs für Manifest, Pfade und Overrides; pack_import.rs für Ticket-Vorschau einer Archivkopie, Drag-and-drop/Dateiauswahl, optionale Dateien, Hash-Downloads, zusätzliche lokale Dateien und neue Instanzregistrierung nach erfolgreichem Staging. Fehlgeschlagene Downloads behalten das Ticket zur Ergänzung/Wiederholung. Importierte Profile tragen extra.vertix_import, damit die vier Loader-Installer bei fehlendem Pin nicht auf eine andere Version fallen.

Erkennung: mod_identity.rs; Modrinth SHA1-Batches, danach CurseForge-Fingerprints mit SHA1-Bestätigung. Namen und Autoren nur zur Anzeige, nie als Identitätsnachweis. Cache .vertix-mod-identities.json prüft Pfad, Größe und Änderungszeit und speichert Hashes. Erkennung übernimmt kein Dateieigentum. Nur ausdrücklich angeforderte Updates verwenden local_replacement/claim_remote mit Inhalts-Hash und ohne mehrdeutige lokale Versionen. Inhaltsansicht erkennt beim Öffnen, bei sichtbaren Dateiänderungen und alle 30 Sekunden; die regelmäßige Inhaltsabfrage liest nur den Cache.

Prüfungen und Grenzen: changelogs/verification-0.11.0.md. Persönliche Installation und Desktop-Setup werden nicht verändert; Auslieferung über den bestehenden Updatekanal.



## Veröffentlicht: 0.10.1 / Core 1.5.0

Release: https://github.com/LeonM1501/vertix-client/releases/tag/v0.10.1. Öffentlicher Commit `2ce405732f8d8d438571fbf09b1b178efe69dad3`, korrespondierender Source-Snapshot `d98ea97d577d043e4153ed6e5d91ede130a46461`. Workflow `39819048470` erfolgreich; beide vollständigen öffentlichen Downloads und GitHub-Asset-Digests gegen SHA-256 bestätigt. Native Release-Kompilierung erfolgreich (8m05s), NSIS erfolgreich, beide exakten Core-JARs 1.5.0 eingebettet. Normaler main/version.json-Cache zeigte unmittelbar nach Veröffentlichung noch 0.10.0 (GitHub max-age=300); die Commit-Adresse und das öffentliche Release lieferten bereits 0.10.1. 0.10.0 wurde zuvor auch an der normalen Update-Adresse verifiziert.

Zusätzlicher Nutzerauftrag: echte gerenderte Minecraft-Blöcke als Instanzbild mit wählbarem Hintergrund. `ProfileIcon.tsx` enthält 24 transparente 256px-PNG-Kompositionen aus lokalen Minecraft-Texturen, kein externer Bilderdienst. Auswahl wird als gewöhnliches PNG in der bereits vorhandenen `vertix_icon.image`-Struktur gespeichert; `symbol=box` bleibt mit der bestehenden nativen Validierung kompatibel. Hintergrund bleibt ein validierter Hex-Farbwert. Bestehende Icons bleiben unverändert. `scripts/render-block-portraits.py` reproduziert die orthografische Projektion, Flächenbeleuchtung und Schatten aus einer lokal vorhandenen Minecraft-Client-JAR; Minecraft-Artwork gehört Mojang/Microsoft. Keine Minecraft-JAR im Source. Core bleibt 1.5.0. Client-Version 0.10.1, weil 0.10.0 bereits veröffentlicht war.


## Veröffentlicht: 0.10.0 / Core 1.5.0 (22. Oktober 2026)

Veröffentlicht: https://github.com/LeonM1501/vertix-client/releases/tag/v0.10.0. Öffentlicher Commit `3f709ea6c3e68ae61e67e94e841b2e01c2120c34`; korrespondierender Code-Snapshot `dfba1605b87aa94e3e3937c81c011fe5dc3412b3`. Workflow `39816786418` erfolgreich. Setup und Source erneut von den öffentlichen Downloadadressen geladen und SHA-256 bestätigt; beide GitHub-Release-Digests identisch. Persönliche Installation und Desktop-Setup unverändert. Ältere Statusabschnitte bleiben historische Nachweise. Funktionen und Verwendung: `changelogs/0.10.0.md`; konkrete Prüfungen/Grenzen: `changelogs/verification-0.10.0.md`.

Beliebt/Downloads verwendet in `catalog.rs` ausschließlich Modrinths Rangfolge und direkte Pagination. Andere Sortierungen und Versionsauflösung bleiben anbieterübergreifend. Ein expliziter nativer Live-Test vergleicht erste und tiefe Seite mit der offiziellen API.

`PerformanceModeModule` nutzt `OptionOverrides`: nur weiterhin selbst verwaltete Werte werden zurückgesetzt. Manuelle Änderungen bleiben erhalten. `OptionsMixin` setzt Originale zum Speichern ein und nimmt das Profil danach wieder auf. Zoom wird vor dem Speichern ebenfalls zurückgenommen. `MinecraftMixin` sammelt Renderintervalle und stellt Optionen beim Beenden wieder her. Maximal 512 Samples, Sortierung nur einmal pro Sekunde. Session-Zeit beginnt bei Welt-/Dimensionswechsel neu.

`PerformanceSetup.tsx` bietet drei optionale Optimierungsmods über die vorhandenen kompatiblen Installationswege an und überspringt erkannte lokale Dateien. `QuickSwitch` ist Strg+K; `ContentCatalog` speichert maximal 200 lokale Merkliste-Projekte. Slate ist zusätzlich wählbar. `logDiagnostics.ts` arbeitet rein lokal ohne Log-Übertragung.

Automatisches Windows-Java ab 25 verwendet separat gespeichertes Temurin. Offizielle Metadaten liefern SHA-256 zur Prüfung vor dem Entpacken. Gültige eigene Java-Pfade bleiben vorrangig, alte Java-Ordner werden nicht gelöscht. Der bisherige Zulu-Build scheiterte wieder nativ; vollständige Tests mit frischem Temurin und normalem JIT bestanden. Keine pauschalen JVM-Performanceflags hinzugefügt.

## Veröffentlicht: 0.9.0 / Core 1.4.0 (22. Oktober 2026)

Veröffentlichung erfolgreich: https://github.com/LeonM1501/vertix-client/releases/tag/v0.9.0. Öffentlicher Commit `bf238ef8752b43dbc2e4fd46cf2ab6e550a5d825`, korrespondierender Source-Snapshot `72bc8d152a9e883f096122f4c18a4a809a5d3c25`. Der normale Updatekanal liefert 0.9.0; beide Downloads wurden erneut abgerufen und gegen ihre SHA-256-Werte geprüft. GitHub-Workflow 39768313704 war erfolgreich. Die folgenden lokalen Statusabschnitte dokumentieren frühere Arbeitsstände. EXE und Setup wurden frisch mit Core 1.4.0 gebaut; die alten vorbereiteten 0.9.0-Artefakte wurden ersetzt. Changelog: `changelogs/0.9.0.md`; Prüfungen: `changelogs/verification-0.9.0.md` und `changelogs/verification-core-1.4.0.md`. Der private API-Key bleibt ausschließlich DPAPI-geschützt beim lokalen Windows-Konto und wird nicht verteilt. Andere PCs richten ihren eigenen Key in den Inhaltsquellen ein. Persönliche Installation und Desktop-Setup werden durch die Veröffentlichung nicht ersetzt.

## Lokale Weiterentwicklung: Core 1.4.0 / Armor HUD (19. Oktober 2026)

Noch nicht veröffentlicht oder hochgeladen. Das bestehende Armor-HUD integriert MIT-lizenzierte Regeln aus uku3lig/armor-hud; Herkunft und Änderungen: `third_party/uku-armor-hud/UPSTREAM.md`. Neue Anpassungen betreffen Slot-Filter, Hände, Anordnung, Haltbarkeitsformate, relative/absolute Warnschwellen, optionale Warnsymbole/-töne und Vertix-Oberflächen. Bestehende Setting-IDs bleiben kompatibel. `Module.getSettingGroup` ermöglicht vier Modulgruppen im vorhandenen scrollbaren `SettingsPopup`.

Core-JARs für 26.2/26.3 sind lokal als 1.4.0 gebaut und in `vertix_core.rs` referenziert. Der Dateiname im Build liest die Version aus `fabric.mod.json`. Das Ingame-Testskript wählt den Test-Mixin über `-TestClassName`, erzeugt eine isolierte Spiel-/Konfigurationsumgebung und bindet die aktuelle Core-Version ein. `ArmorHudRuntimeTest` erzeugt eine eigene Offline-Testwelt und prüft Darstellung, Vorschau vor Weltstart, Einstellungen, Speicherung und Verschieben. Keine persönlichen Profile oder Welten verwenden. Details: `changelogs/verification-core-1.4.0.md`.

Die vorher vorbereiteten Client-0.9.0-Binärdateien/Setup-/Source-Archive enthalten noch Core 1.3.1. Für eine spätere Veröffentlichung müssen diese neu gebaut werden. `version.json`, Desktop-Setup und installierter Client sind unverändert.

## Vorher vorbereitet: Client 0.9.0 / Core 1.3.1

Noch kein öffentliches Release. `version.json` bleibt absichtlich auf dem zuletzt veröffentlichten Stand 0.8.1. Am 22. Oktober 2026 wurde der neue CurseForge-Key live bestätigt und lokal DPAPI-geschützt gespeichert. Suche, kompatible Versionsabfrage und autorfreigegebener Sodium-Download mit SHA-1-Prüfung waren erfolgreich. Die frühere Ablehnung bezog sich auf den alten Key. Kein Update veröffentlicht und keine persönliche Mod-Installation geändert; vollständiger Katalog-UI-Ablauf bleibt separat zu prüfen.

- `catalog.rs` stellt gemeinsame Such-, Projekt- und Versionsbefehle bereit. Provider-IDs sind namensgetrennt: Modrinth-ID unverändert, CurseForge-Projekt `cf:<projectId>`, CurseForge-Version `cf:<projectId>:<fileId>`.
- `catalog_identity.rs` fasst nur verifizierte Zuordnungen zusammen. Gemeinsame Datei-SHA1 oder gleiche GitHub-Repository bei passendem Projekt-Slug liefern die Zuordnung. Positive Identitäten werden lokal in `providers/catalog-identities.json` zwischengespeichert; keine Zugangsdaten.
- `catalog_versions.rs` sortiert kompatible Dateien anhand der Mod-Version (Minecraft-Versionsanteile werden entfernt), sonst anhand des Veröffentlichungsdatums. Stabile Releases bleiben bevorzugt. Bei Gleichstand gewinnt Modrinth. `modUpdates.ts` prüft dieselben Fälle beim Ermitteln tatsächlich neuer Downloads.
- `instance_content.rs` speichert die tatsächliche Downloadquelle als `ModSource` und die gemeinsame ID als `Mod.extra.vertix_catalog_id` (durch serde flatten an der JSON-Wurzel). Beim Quellenwechsel wird der alte Eintrag entfernt; alte Dateien werden weiterhin nur mit belegter SHA1/Ownership ersetzt oder zurückgezogen.
- `provider_keys.rs` liest `VERTIX_CURSEFORGE_API_KEY` oder Windows-DPAPI aus `%APPDATA%/vertix/providers/curseforge.bin`. Niemals einen privaten Key in Code, Profile, Installer oder URLs schreiben. Die Oberfläche bekommt nur einen Konfigurationsstatus. `save_curseforge_key` prüft den neuen Key vor dem Speichern; bei Ablehnung bleibt ein vorheriger Key erhalten. Andere PCs benötigen ihren eigenen Key oder künftig einen getrennt betriebenen Dienst; ein gemeinsamer privater Key lässt sich in einer verteilten Desktop-EXE nicht geheim halten.
- CurseForge-Downloads verwenden `x-api-key`, auch im allgemeinen Mod-Downloader. Nur HTTPS auf forgecdn.net bzw. dessen Subdomains erhält diesen Header. API-Weiterleitungen sind gesperrt, CDN-Weiterleitungen dürfen nur innerhalb dieses Hostbereichs bleiben.
- Gemeinsame Suche: Minecraft-/Loaderfilter für beide Anbieter. Modrinth-Kategoriefilter schränken ausdrücklich auf Modrinth ein, da die Taxonomien verschieden sind. Das Suchfenster umfasst zunächst höchstens 1000 Treffer; die kombinierte Gesamtzahl ist eine Schätzung. Projektidentitäten können nur zusammengeführt werden, wenn eine gemeinsame Quelle oder Datei belegbar ist. Nicht freigegebene CurseForge-Dateien werden nicht durch synthetische Download-URLs umgangen.
- Prüfungen und verbleibender Live-Test siehe `changelogs/verification-0.9.0.md`.

## Aktueller Stand: Client 0.8.1 / Core 1.3.1

R-Shift führt direkt zu `VertixMenuScreen` (ohne Elternfenster). Schließen führt zurück ins Spiel. Die Tabs oben wechseln Mods/Profile/HUD; Kategorien bleiben in der Seitenleiste. `SettingsPopup` berechnet dieselben gruppierten Zeilen für Darstellung und Eingaben. Gruppen sind nur vorübergehend eingeklappt, gespeicherte Werte ändern sich dadurch nicht. Auswahlfelder unterstützen Vorwärts/Rückwärts; Nummern werden mit dem Regler geändert. Die Spieltests wählen je Fabric-/ASM-Artefakt nur eine Bibliotheksversion aus dem Cache, um doppelte Loader-Klassen zu vermeiden. Frühere Abschnitte beziehen sich auf ihre genannten Versionen.

## Aktueller Übergabestand vom 18. Oktober 2026: Client 0.8.0 / Core 1.3.0

Der aktive Arbeitsordner liegt jetzt unter `C:/Users/Leonx/Documents/Codex/Vertix-Client-Source` und besitzt eine normale Git-Historie. Die vorherige SSD-Kopie unter AppData ist keine Grundlage für neue Änderungen. Die folgenden älteren Abschnitte beschreiben die jeweils genannte frühere Version.

- `managed_mods.rs`: Verwaltungsmanifest Version 2 mit Inhaltsprüfsummen und Quelle. Lokale Dateien werden niemals als Remote-Besitz registriert. Alte Namenslisten werden defensiv migriert. Aktive, noch nicht aufgelöste Profilmods bleiben erhalten. Explizite Remote-Versionswechsel dürfen bekannte alte Dateien nur anhand ihrer bisherigen Prüfsumme ersetzen; Nutzeränderungen erzeugen einen Konflikt statt Datenverlust.
- `content_import.rs`: Klassifikation von Archiv-Inhalten, Normalisieren von Wrapper-Ordnern, sichere Welt-Extraktion und Warteschlange `.vertix-pending`. Vorhandene Dateien werden nicht überschrieben. `prepare_pending` läuft in beiden Startwegen vor dem Laden. `.vertix-pending-mods` markiert geänderte Modmetadaten, `.vertix-retire-mods.json` hält explizit zu ersetzende Remote-Versionen fest. Ein laufendes Minecraft wird nicht mit ausgetauschten JARs versorgt.
- `instance_log.rs`: vollständige Datei mit Token-Redaktion. Die alte 262144-Byte-Abschneidung ist entfernt.
- `ProjectDetails.tsx` und `SafeMarkdown.tsx`: Beschreibung und Versionen, kompatible Zielinstanzen, Markdown/GFM sowie bereinigtes HTML. Aktive Fremdinhalte werden entfernt. Die [API-Zuordnung anhand eines Datei-Hashes](https://docs.modrinth.com/api/operations/versionfromhash/) wird beim Öffnen einer lokalen Detailansicht angefragt; die JAR selbst wird nicht hochgeladen.
- `ProfileIcon.tsx`: eigene Symbole und PNG-/JPG-/WebP-Import, auf 256 × 256 PNG normalisiert. Der Server validiert Format, Maße und Größe. `Profile.extra` ist in Rust mit `serde(flatten)` versehen: Das Frontend muss `profile.vertix_icon` lesen, nicht ausschließlich `profile.extra.vertix_icon`.
- Angeheftete Instanz-IDs liegen unter `vertix-pinned-instances-v1`. Vertikale Designs zeigen Verknüpfungen in der Seitenleiste, Fokus/Terminal in einer zusätzlichen Navigation.
- Core 1.3.0: `HudPlacement` enthält unabhängige Platzierungsregeln. Modmenü und HUD-Editor verwenden dieselben Regeln. Der Editor wählt bei Überschneidungen das zuletzt gezeichnete Element. Rückgängig stellt die Positionen vom Öffnen des Editors wieder her, keine Werkseinstellungen oder Nutzerfarben.

Prüfungen: TypeScript und Vite; bestehende RAM-/Kompatibilitäts-/Update-Regressionen; neue Beschreibungs- und Instanzbildtests; separater Rust-Harness für die tatsächlichen Produktionsalgorithmen ohne WebView/Nutzerprofile; Java-Layout-/Platzierungstests und isolierte Spieltests unter `scripts/test-ingame-ui.ps1`. Ein UI-Test bestätigt weder Microsoft-Anmeldung noch einen realen Discord-Stream. Testskripte erzeugen bei jedem Lauf eigene Verzeichnisse und verwenden eine Offline-Testidentität. Historische Ergebnisse und offene Punkte weiter unten behalten ihren jeweiligen Versionsbezug.

Stand: 14. Oktober 2026. Programmstand dieser Änderung: **Client 0.7.0 / Vertix Core 1.2.0**. Historische Prüfergebnisse zu 0.6.0 weiter unten gelten ausschließlich für dieses frühere Release; aktuelle Nachweise siehe `artifacts/verification/0.7.0`.
Diese Datei hält den fachlichen Kontext, die bisherigen Entscheidungen und den tatsächlich implementierten Ablauf fest. Sie ist eine Einstiegshilfe für weitere Entwickler; bei späteren Änderungen müssen Code und Dokumentation gemeinsam aktualisiert werden. Sie enthält keine Zugangsdaten oder privaten Gesprächsprotokolle.

## 1. Welche Repository ist wofür da?

| Repository | Aufgabe |
| --- | --- |
| [LeonM1501/vertix-client-source](https://github.com/LeonM1501/vertix-client-source) | Private Zusammenarbeit am vollständigen Source. Hier Änderungen entwickeln und dokumentieren. |
| [LeonM1501/vertix-client](https://github.com/LeonM1501/vertix-client) | Öffentliche Update-Verteilung: `version.json`, versionierte Downloads und GitHub Releases. |

Der Source-Stand vor dieser Dokumentation ist Commit `7209eb3fc145781fa575495bce84234d3405df17` (0.6.0). Der lokale Arbeitsordner beim letzten Release war `E:\Vertix-Client-Source`; er ist ein Source-Snapshot ohne `.git`. Für die weitere Zusammenarbeit am besten die private Repository klonen und vor Änderungen den aktuellen Branch abrufen. Remote-Änderungen anderer Entwickler nicht durch einen älteren lokalen Snapshot ersetzen.

Ein Commit in der privaten Source-Repository veröffentlicht **kein Client-Update**. Die Update-Veröffentlichung erfolgt gesondert in der öffentlichen Repository. Eine neue Dokumentation benötigt keinen Versionssprung und keinen neuen Installer.

## 2. Produkt und gewünschtes Verhalten

Vertix ist ein Windows-Launcher für Minecraft Java mit eigenen Instanzen, Inhaltsverwaltung und einer gebündelten Fabric-Clientmod. Technische Grundlage ist ein Fork des NoRiskClient-Launchers 0.6.28; Lizenz- und Herkunftshinweise bleiben erhalten. Die aktiven Oberflächen verwenden eigenes Vertix-Branding.

Wichtige Anforderungen aus der bisherigen Entwicklung:

- Saubere, einfach bedienbare Oberflächen; keine Glow-Effekte, dekorativen Farbverläufe oder beliebig gemischten Akzentfarben. Referenzbilder liefern Anregungen für Funktionen und Aufteilung, keine zu kopierende Marke oder Farbpalette.
- Launcher-Designs sind unter Einstellungen wählbar: Mono, Papier, Terminal, Galerie, Fokus und OLED. Schriftgröße, Abstände und Ecken sind anpassbar.
- Minecraft-Version, Loader und konkrete Loader-Version sollen beim Erstellen und Bearbeiten einer Instanz wählbar sein. Ohne feste Loader-Version wird die neueste kompatible verwendet. RAM-Regler und RAM-Empfehlung gehören zu den Instanzeinstellungen.
- Inhalte entdecken startet als globaler Katalog. Nutzer filtern beispielsweise nach Version und Loader und wählen bei der Installation die Zielinstanz. Nicht kompatible Instanzen dürfen keine vermeintlich passende Installation bekommen.
- Beim Betreten einer Instanz werden Mod-Updates automatisch geprüft. „Alle aktualisieren“ erscheint nur bei tatsächlich gefundenen Updates. Lokale Mods ohne bekannte Updatequelle sind kein Beleg für ein verfügbares Update.
- Ein Client-Update soll heruntergeladen und ohne erneuten Setup-Assistenten angewendet werden; danach startet Vertix neu.
- Die persönliche Installation und die Setup-Datei auf dem Desktop werden durch Source- oder Release-Arbeit nicht automatisch ersetzt oder deinstalliert. Das ist ein gesonderter Auftrag. Nutzer testen den normalen Updateweg selbst.

## 3. Wo liegt welcher Code?

| Pfad | Bedeutung |
| --- | --- |
| `src/` | Aktive React-/TypeScript-Oberfläche, einschließlich Launcher-Updateanzeige in `App.tsx`. |
| `src-tauri/src/` | Rust-Backend: Profile, Minecraft-Vorbereitung, Inhalte, Anmeldung und Updates. |
| `src-tauri/src/updater.rs` | Aktiver Vertix-Updatekanal, Download und Start des stillen Installers. |
| `src-tauri/src/utils/updater_utils.rs` | Historischer Upstream-Code; nicht mit dem aktiven Vertix-Updater verwechseln. |
| `installer.nsi` | Eigener Windows-Installer und stiller Update-Modus. |
| `build-release.ps1` | TypeScript/Vite und natives Release-EXE, einschließlich `libunwind.dll`. |
| `vertix-core-mod/` | Java-Source der Ingame-Mod, Build, Tests und versionsbezogene Fabric-Abhängigkeiten. |
| `src-tauri/src/minecraft/vertix_core.rs` | Kompatibilitätsprüfung, eingebettete Core-JARs und Installation in die Instanz. |
| `src-tauri/resources/mods/` | Gebaute Core-JARs, die per `include_bytes!` ins EXE eingebettet werden. |
| `.github/workflows/publish-release.yml` | Veröffentlichung der öffentlichen Downloads als GitHub Release. |
| `version.json` | Manifest des aktuellen Releases; die öffentliche Kopie steuert den Updatekanal. |
| `changelogs/` | Versionsbezogene Änderungen. |
| `packaging/Initialize-Updates.ps1` | Übergangshilfe für den ursprünglichen 0.1.0-Updatekanal. |
| `artifacts/` | Lokale Builds, Verifikationen und Sicherungen; kein vollständiger Source-Upload. |

Falls `upstream/` lokal vorhanden ist, ist das eine historische Referenz und nicht das aktive Frontend. Die einmaligen Skripte `scripts/prepare-vertix.mjs` und `scripts/finish-vertix.mjs` nicht erneut auf dem bereits angepassten Source ausführen.

## 4. Update-System: Was passiert auf dem Nutzer-PC?

Die Desktop-Oberfläche prüft beim Start und anschließend alle **30 Sekunden** auf ein Update. Im Über-Dialog gibt es außerdem „Nach Updates suchen“. Die Browser-Designvorschau führt diesen Desktop-Ablauf nicht aus.

Der aktive Rust-Updater arbeitet in dieser Reihenfolge:

1. Falls vorhanden: `%APPDATA%\vertix\update_release.json` lesen. Eine gültige höhere Versionsnummer in dieser lokalen Test-/Übergangsdatei hat Vorrang vor dem Onlinekanal.
2. Andernfalls `https://raw.githubusercontent.com/LeonM1501/vertix-client/main/version.json` abrufen. Die Anfrage hat derzeit drei Sekunden Timeout; Netzwerkfehler führen zu keinem angebotenen Update.
3. Die Kandidatenversion mit der eingebauten Paketversion über SemVer vergleichen. Gleiche, ältere oder ungültige Versionen werden nicht angeboten.
4. Auf Nutzeraktion den Installer in `%APPDATA%\vertix\updates\Vertix-Client-Setup.part` herunterladen. HTTP-Fehler, leere Downloads und eine bekannte, nicht passende Gesamtlänge führen zum Fehler. Erst nach Abschluss wird die Datei zu `Vertix-Client-Setup.exe` umbenannt.
5. Beim Installieren das EXE mit `/S /UPDATE` als separaten Prozess starten, den lokalen Trigger entfernen und Vertix beenden.
6. NSIS wartet bis zu etwa 60 Sekunden auf die Freigabe des alten EXE, ersetzt die Programmdateien und startet Vertix nach erfolgreichem Update neu.

Es wird weiterhin die NSIS-Installationsengine verwendet, aber ohne Setup-Assistenten. Es ist bisher kein Delta- oder In-Process-Patcher. Ein separat geöffnetes Setup bietet weiterhin die normale Installation an. Für den Übergang von 0.2.0 erkennt NSIS zusätzlich den bisherigen Update-Downloadordner und aktiviert dort den stillen Modus auch ohne `/UPDATE`.

Standard-Installationsort: `%LOCALAPPDATA%\Programs\Vertix Client`. Ein gespeicherter eigener Installationspfad wird über HKCU berücksichtigt. Profildaten liegen getrennt davon unter `%APPDATA%\vertix\VertixClient`, Instanzen unter `data/profiles`.

### Manifest

Schematisches Beispiel für ein **künftiges**, noch nicht veröffentlichtes Release:

```json
{
  "version": "0.7.0",
  "title": "Vertix 0.7.0",
  "notes": "Beschreibung der tatsächlich enthaltenen Änderungen",
  "installer_url": "https://raw.githubusercontent.com/LeonM1501/vertix-client/main/releases/0.7.0/Vertix-Client-Setup.exe",
  "sha256": "<SHA-256 des fertigen Installers>",
  "source_url": "https://raw.githubusercontent.com/LeonM1501/vertix-client/main/releases/0.7.0/Vertix-Client-0.7.0-source.tar.gz",
  "source_sha256": "<SHA-256 des zugehörigen Source-Archivs>"
}
```

**Tatsächliche Prüfgrenze in 0.6.0:** Der Veröffentlichungsworkflow prüft beide SHA-256-Werte. Der aktive Client-Updater liest `sha256` jedoch noch nicht aus und prüft beim Download bisher keine kryptografische Prüfsumme oder Signatur. Die Existenz des Manifestfeldes ist keine clientseitige Integritätsprüfung. Das ist eine konkrete offene Verbesserung; bei Umsetzung Hash und Versionsdaten bis zur Installation an den Download binden.

Es gibt genau einen angebotenen neuesten Versionsstand, keinen Versionsauswahldialog. Weil jedes Update ein vollständiger Installer ist, kann eine ältere Version grundsätzlich direkt auf den aktuellen Stand wechseln. Für künftig notwendige Datenmigrationen muss dieser Sprung separat geprüft werden.

### Braucht es einen Server oder eine CMD-Datei?

Für den bestehenden Kanal genügt öffentliches GitHub-HTTPS-Hosting; ein eigener Server ist nicht erforderlich. Die private Source-Repository eignet sich nicht als unauthentifizierter Downloadkanal. Keine GitHub-Zugangstokens in Clients einbauen.

Der ursprüngliche 0.1.0-Client hatte eine falsche GitHub-Adresse fest eingebaut. Ein später angepasstes 0.1.0-Setup initialisiert den Übergang automatisch über `Initialize-Updates.ps1` und das 0.2.0-Manifest. Dafür braucht der Nutzer vorher keine CMD manuell auszuführen. Bereits früher installierte alte Binaries bekommen eine korrigierte Adresse aber nicht durch einen bloßen Source-Commit; sie benötigen den einmaligen Übergang oder ein geeignetes Setup. Neuere Clients verwenden die richtige Adresse direkt.

## 5. Release bauen und veröffentlichen

### Voraussetzungen

Node.js/npm, Rust/Cargo mit funktionierender Windows-Toolchain, WebView2 und NSIS. Für die Core-Mod zusätzlich ein vollständiges JDK; für Minecraft 26.2/26.3 Java 25 oder neuer zur Laufzeit. Die bisherigen Windows-Releases wurden mit `stable-x86_64-pc-windows-gnullvm` gebaut. Dessen `libunwind.dll` gehört zwingend mit ins Paket; eine MSVC-Toolchain ist ein anderer Buildweg und wurde damit nicht automatisch validiert.

Das Mod-Buildskript hat aktuell einen lokalen JDK-24-Standardpfad. Deshalb `-JdkHome` ausdrücklich auf ein passendes vollständiges JDK setzen; ein reines Java-Runtimeverzeichnis enthält kein `javac`. Das Skript benötigt außerdem bereits vorbereitete offizielle Minecraft-JARs für **beide** Versionen und Bibliotheken im Metadatenordner. Sie werden nicht als Spiel-JARs ins Source-Repo aufgenommen. Details: [Core-Build](vertix-core-mod/README.md).

### Reihenfolge

1. Aktuellen Source abrufen, Änderungen abschließen und die Tests des betroffenen Bereichs ausführen.
2. Clientversion konsistent in `package.json`, den Root-Paketangaben von `package-lock.json`, `src-tauri/Cargo.toml`, dem App-Eintrag in `src-tauri/Cargo.lock` und `src-tauri/tauri.conf.json` erhöhen.
3. Bei Modänderungen deren eigene Version konsistent in Fabric-Metadaten, Buildskript, Rust-Konstante und Ressourcen-Dateinamen pflegen. Client- und Core-Version sind unabhängig.
4. **Zuerst Core-JARs bauen**, dann das Rust-EXE. Die JARs sind im EXE eingebettet; eine nachträglich geänderte JAR erfordert einen erneuten Rust-Build.
5. Produktionsfrontend und EXE bauen, passende Runtime-DLLs bereitstellen und erst daraus NSIS erstellen.
6. Korrespondierenden Source ohne Caches, persönliche Daten und temporäre Dateien archivieren. Erforderliche Quellen, Buildskripte, Lockfiles und Lizenztexte mitnehmen. Das Source-Archiv des Releases 0.6.0 enthält den Root-`version.json` nicht, um einen Selbstbezug über dessen Source-Prüfsumme zu vermeiden.
7. Fertige Downloads hashen, Changelog und Manifest erstellen und auf Konsistenz prüfen.
8. Private Source-Repository aktualisieren. In der öffentlichen Repository beide Dateien unter `releases/<Version>/` und das neue Root-`version.json` **gemeinsam in einem Commit** bereitstellen. Sonst können Clients schon ein Update sehen, dessen Datei noch fehlt.
9. Öffentlichen Workflow und GitHub Release prüfen. Downloads erneut vom öffentlichen Kanal abrufen und mit den lokal ermittelten Hashes vergleichen. Einen Updateversuch aus einer älteren Version mit getrennten Testdaten prüfen.

Beispielbefehle ab Projektwurzel, Platzhalter und Toolpfade anpassen:

```powershell
npm ci
./vertix-core-mod/build.ps1 -JdkHome '<vollständiges JDK-Verzeichnis>'
./build-release.ps1 -ArtifactDirectory ./artifacts/releases/0.7.0
# Passende x64-WebView2Loader.dll zusätzlich in dieses Artefaktverzeichnis kopieren.
# build-release.ps1 kopiert das EXE und die libunwind.dll der aktiven Toolchain.
makensis /V2 /DARTIFACT_DIR=artifacts\releases\0.7.0 /DAPP_VERSION=0.7.0 installer.nsi
Get-FileHash ./artifacts/releases/0.7.0/Vertix-Client-Setup.exe -Algorithm SHA256
```

`0.7.0` ist hier nur ein Beispiel. `build-release.ps1` verwendet `--features custom-protocol`: Damit wird die gebaute Oberfläche eingebettet. Ein veröffentlichter Client darf nicht von einem laufenden Vite-Server auf localhost abhängen. Das war die Ursache eines früheren Setup-Problems. Das Skript erzeugt weder automatisch die Java-JARs noch den fertigen NSIS-Installer.

Der Workflow `publish-release.yml` läuft bei Änderungen an `version.json` auf `main` oder manuell. Sein Repository-Guard erlaubt die Veröffentlichung ausschließlich in `LeonM1501/vertix-client`. Er lädt die Dateien vom **auslösenden Commit**, prüft beide Hashes und erzeugt `v<Version>` samt Installer und Source-Archiv. Veröffentlichte Versionen nicht still mit anderen Binärdateien überschreiben; für neue Inhalte eine neue Version verwenden.

### Referenz: veröffentlichtes 0.6.0

- [Release v0.6.0](https://github.com/LeonM1501/vertix-client/releases/tag/v0.6.0)
- Installer: `Vertix-Client-Setup.exe`, 7.105.236 Bytes; SHA-256 `191d75119e9b4453adf93c6ac7c07f610fa1ad42c586563788dc94fd7bbe119b`.
- Source: `Vertix-Client-0.6.0-source.tar.gz`, 3.005.454 Bytes; SHA-256 `852630c5c9f8420cf1f23dbecbcf7d42072f6ea2237450bc074a3c65cf1dbd03`.

## 6. Ingame-Mod und HUD

Core 1.1.0 unterstützt ausschließlich **Fabric mit Minecraft 26.2 oder 26.3**, Fabric Loader mindestens 0.19.3 und Java mindestens 25. Andere Launcher-Profile bleiben möglich, bekommen diese Core-Mod aber nicht automatisch. Nicht pauschal 1.21, Quilt, Forge oder NeoForge als Core-kompatibel markieren.

Für jede unterstützte Minecraft-Version gibt es eine eigene JAR. Mit 26.3 änderten sich Eingabecodes von GLFW auf SDL; insbesondere Right Shift und Maustasten haben andere Werte. `InputConstants` gegen die jeweilige Spielversion kompilieren, keine versionenübergreifenden magischen Tastennummern verwenden. Die passende Fabric-Key-Mapping-API ist als geprüftes verschachteltes Modul enthalten; das komplette Fabric-API-Paket ist hierfür nicht notwendig. Zugehörige Lizenztexte erhalten.

Beim Vorbereiten einer kompatiblen Instanz installiert `ensure_vertix_core` die eingebettete JAR. Es vergleicht den gesamten Inhalt und ersetzt auch eine gleich große veraltete Datei atomar. Anschließend werden nur präzise erkannte eigene `vertix-core-fabric-<numerische Versionen>.jar[.disabled]` entfernt; fremde Mods bleiben erhalten. Für nicht unterstützte Profile werden diese eigenen Core-Dateien entfernt. Eine manuell hinzugefügte zweite Core-JAR mit anderem Namen kann trotzdem doppelte Mod-IDs verursachen und muss bei der Diagnose berücksichtigt werden.

Nach einem Client-Update kommt die neue Core-Mod bei der nächsten Profilvorbereitung in die Instanz. Ein bereits laufendes Minecraft lädt dadurch keine neuen Klassen: Minecraft neu starten.

Wichtige Java-Bereiche unter `vertix-core-mod/src/main/java/client/vertix/core/`:

- `gui/VertixHomeScreen`: kompakte Right-Shift-Startansicht mit Modmenü, Profilen und HUD-Editor.
- `gui/VertixMenuScreen`: Kategorien, Suche, responsive Modkarten, Einstellungen und Presets.
- `gui/SettingsPopup` und `gui/MenuLayout`: scrollbare Einstellungen und gemeinsame Layout-/Treffergeometrie.
- `gui/HudStyle`: einheitliche Graphitflächen, helle Schrift, Abstände und Höhe für die HUD-Anzeigen. FPS, CPS, Koordinaten, Sprint, Rüstung, Keystrokes, Effekte und Target-HUD sollen zusammenpassen.
- `gui/HudEditorScreen`: Vorschau und Verschieben der Anzeigen. Die normale HUD-Ausgabe wird währenddessen übersprungen, um doppelte Anzeigen zu vermeiden.
- `config/ConfigManager` und `config/LegacyHudStyle`: gespeicherte Einstellungen und einmalige Migration alter Standardfarben/-positionen.

Globale Modkonfiguration: `%APPDATA%\vertix\vertix-client-config.json`; lokaler Ausweichpfad: `<Instanz>\config\vertix-client.json`. Schema aktuell Version 2. Die Migration ersetzt bekannte alte Standardfarben durch Offwhite und passt alte Standardpositionen/-deckkraft an. Individuell geänderte Werte und Aktivierungszustände sollen erhalten bleiben. Keine pauschale Rücksetzung aller Nutzerkonfigurationen als Designfix.

## 7. Prüfung und bekannte Grenzen

Für 0.6.0 wurden TypeScript-Prüfung, Produktionsbuild und diese Regressionen ausgeführt:

```powershell
node scripts/test-appearance-ram.cjs
node scripts/test-content-compatibility.cjs
node scripts/test-mod-updates.cjs
```

Zusätzlich: Java-Kompilation für 26.2 und 26.3, `MenuLayoutTest`, `LegacyHudStyleTest` und die Rust-Core-Tests für exakte Kompatibilität sowie Installation/Upgrade/Reparatur unter Erhalt fremder Dateien. Beispiele für Java-Tests stehen im Core-README. Der Windows-Rust-Testharness benötigte lokal eine Common-Controls-v6-Manifestdatei und die passende `libunwind.dll`; ein Testharness-Startfehler ist nicht automatisch ein Fehler im veröffentlichten Tauri-EXE.

Die Oberfläche wurde in einer isolierten 26.3-Testinstanz im Spiel überprüft. Die verwendete Eingabeautomation lieferte Right Shift nicht zuverlässig als rechte Shift-Taste; zum Öffnen wurde im Test eine andere Taste gebunden. Die produktive Right-Shift-Belegung wurde im Code und im Minecraft-Tastenmenü geprüft. Das ist keine Behauptung eines erfolgreich automatisierten physischen Right-Shift-Tastendrucks.

Lokale Nachweise des letzten Releases liegen unter `artifacts/verification/0.6.0`, unter anderem `hud-final.png`, `embedded-mods.json`, `published-downloads.json` und `publication.json`. Sie sind lokale Prüfartefakte und werden nicht als Teil des gesamten Arbeitsordners ins Source-Repo geladen.

Diagnose häufiger Probleme:

| Symptom | Zuerst prüfen |
| --- | --- |
| Installierter Client zeigt localhost-Verbindungsfehler | War es wirklich ein Produktionsbuild mit `custom-protocol` und aktuellem eingebettetem Frontend? Nicht mit dem temporären OAuth-Callback verwechseln. |
| `libunwind.dll` fehlt | EXE und DLLs aus derselben Toolchain vollständig paketiert? Nur das EXE weiterzugeben genügt nicht. |
| Freund sieht kein Update | Eingebaute Version, richtiger Kanal, Netzwerk/Timeout und lokale Triggerdatei prüfen; danach manuelle Prüfung/Neustart. Kurzzeitiges Raw-CDN-Caching ist möglich, behebt aber keinen falschen Endpunkt. |
| Neuer HUD-Code erscheint nicht | Core vor Rust gebaut? Richtige JAR ins EXE eingebettet? Profil erneut vorbereitet und Minecraft vollständig neu gestartet? Doppelte Core-JAR vorhanden? |
| Unterschiedliches Verhalten in 26.2/26.3 | Passende separat kompilierte JAR und versionsgerechte Eingabecodes verwenden. |
| Mod angeblich aktualisierbar, aber falscher Download | Loader, Minecraft-Version, installierte Versions-ID und die tatsächlich geprüfte Modrinth-Veröffentlichung zusammen betrachten. |

Die eigene Microsoft-Anmeldung liegt in `src-tauri/src/vertix_auth.rs`. Ältere README-Abschnitte beschreiben die Einrichtung und damalige unbestätigte echte Anmeldung. Ein Offline-UI-Test bestätigt weder Microsoft-Anmeldung noch Minecraft-Spielberechtigung; solche Grenzen nicht als nachträglich erfolgreich getestet darstellen.

## 8. Source sauber halten und nächste Arbeit

### Streaming-Verbesserung 0.7.0 / Core 1.2.0

Das optionale Modul `discord_streaming` ist unter R-Shift → Mod Menü → Performance erreichbar und standardmäßig aus. Es setzt über `FramerateLimitMixin` ein zusätzliches Limit von standardmäßig 60 FPS (30–240 einstellbar), ohne niedrigere Vanilla-, AFK- oder Hintergrundlimits zu erhöhen oder Minecraft-Optionen zu überschreiben. Dies soll GPU-Spielraum für Discord schaffen; ein tatsächlicher Discord-Stream oder ein Leistungsgewinn wurde nicht gemessen.

Für den bisherigen GNU-LLVM-Releaseweg muss zusätzlich LLVM-MinGW mit `x86_64-w64-mingw32-clang` im `PATH` vorhanden sein. Der Test kann über `-JavaHome` dieselbe Java-25-Runtime wie der Launcher verwenden, unabhängig vom Build-JDK. Offizielle Assets für 26.3 verwenden Index 34.

LLVM-MinGW 20260616 konnte lokal den von Tauri erzeugten `\\?\`-Iconpfad nicht lesen. `packaging/windres-path-fix.cpp` ist der für diesen Build verwendete kleine Compiler-Adapter: Er entfernt ausschließlich den erweiterten Pfadpräfix aus der generierten RC-Datei und delegiert an den unveränderten Compiler. Bei Bedarf mit `x86_64-w64-mingw32-clang++ -static packaging/windres-path-fix.cpp -o <Adapterordner>/windres.exe` kompilieren, `VERTIX_REAL_WINDRES` auf das echte LLVM-MinGW-`windres.exe` setzen und den Adapterordner im Build-Prozess vor LLVM-MinGW in den `PATH` aufnehmen. Der Adapter wird nicht mit dem Client installiert.

`StreamingWindow` verbindet das Modul mit versionsbezogenen `WindowMixin`-Implementierungen. 26.2 wechselt über GLFW in ein ungeschmücktes Fenster am aktuellen Monitor und bewahrt die vorherigen Fenstermaße. 26.3 verwendet Minecrafts vorhandenes `setExclusiveFullscreen(false)` mit dessen SDL-Fensterverwaltung und stellt beim Ausschalten die vorherige Präferenz wieder her. Die Fensteranpassung gilt nur unter Windows; das zusätzliche FPS-Limit funktioniert unabhängig davon. Beim Ausschalten entfällt der Zusatzdeckel sofort, der Fensterwechsel folgt beim nächsten Spiel-Tick. F11 bleibt verfügbar.

Der Core-Build kompiliert neben `src/main/java` genau `src/<Minecraft-Version>/java`. Die JARs heißen jetzt `vertix-core-fabric-26.2-1.2.0.jar` beziehungsweise `vertix-core-fabric-26.3-1.2.0.jar`. Automatische Verteilung und Kompatibilitätsgrenzen bleiben wie oben beschrieben. Der Offline-Runtime-Test `scripts/test-streaming.ps1` nutzt den Test-Mixin unter `src/test/java/client/vertix/test`, getrennte Konfiguration und keine echten Anmeldedaten. Testklassen gehören nicht ins produktive JAR.

Die abschließenden Offline-Funktionstests für 26.2 und 26.3 bestanden mit Java 25 und normalem JIT: opt-in, Standard-/benutzerdefinierter FPS-Deckel, Erhalt niedrigerer Vanilla-Limits, Live-Begrenzung, wiederholter Vollbildwechsel, Rückkehr zur ursprünglichen Fenstergröße und Aufhebung des Limits; für 26.3 zusätzlich Wiederherstellung der exklusiven Vollbildpräferenz. Core liegt im Test nur im Mod-Ordner, nicht zugleich im Laufzeit-Classpath. Launcher-Regressionen für Darstellung/RAM, Inhaltskompatibilität und Mod-Updates bestanden ebenfalls. Diese Prüfungen ersetzen keinen echten Discord-Stream und keinen Updateversuch über eine bestehende persönliche Installation.

Keine `node_modules`, `dist`, `src-tauri/target`, Mod-Buildordner, gesamten `artifacts`, Spielinstallationen, Welten, Kontodaten oder temporären Dateien hochladen. `.gitignore` ist die Grundlage; bei selbst geschriebenen Archiv-/Uploadskripten muss diese Filterung ausdrücklich umgesetzt werden. Die kleinen erforderlichen Mod-Ressourcen und geprüften Build-Abhängigkeiten nicht versehentlich zusammen mit beliebigen JAR-Caches ausschließen.

Lizenztexte und Herkunft erhalten: `LICENSE`, `NOTICE.md` und Lizenzen eingebundener Komponenten gehören zum Source und zum vorgesehenen Paket. Das öffentliche Release führt den passenden Source-Download mit; die private Zusammenarbeit ersetzt diesen Download nicht.

Für weitere Änderungen zuerst den aktuellen Repository-Stand und diesen Text prüfen. Produktfunktionen und Nutzerwerte bei optischen Änderungen erhalten, die betroffenen Versionen wirklich testen und erst den fertigen geprüften Release veröffentlichen. Offene technische Themen sind insbesondere die clientseitige kryptografische Updateprüfung, ein aussagekräftigerer Netzwerkfehlerstatus und reproduzierbar dokumentierte Voraussetzungen für einen frischen Core-Build. Diese Punkte sind hier dokumentiert, nicht als bereits implementiert ausgegeben.

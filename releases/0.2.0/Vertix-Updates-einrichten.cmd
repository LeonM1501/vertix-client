@echo off
title Vertix Updates einrichten
echo Vertix: Updatequelle einmalig einrichten
echo Programmdateien und vorhandenes Setup werden nicht geaendert.
echo.
powershell.exe -NoLogo -NoProfile -Command "$ErrorActionPreference='Stop'; try { [Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; $manifest=Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/LeonM1501/vertix-client/main/version.json' -TimeoutSec 30; if ($manifest.version -notmatch '^\d+\.\d+\.\d+$' -or $manifest.installer_url -ne ('https://raw.githubusercontent.com/LeonM1501/vertix-client/main/releases/'+$manifest.version+'/Vertix-Client-Setup.exe')) { throw 'Unerwartete Updateinformationen. Es wurde nichts geaendert.' }; $dir=Join-Path $env:APPDATA 'vertix'; [IO.Directory]::CreateDirectory($dir) | Out-Null; $target=Join-Path $dir 'update_release.json'; if (Test-Path -LiteralPath $target) { Copy-Item -LiteralPath $target -Destination ($target+'.backup-'+[Guid]::NewGuid().ToString('N')) }; [IO.File]::WriteAllText($target,($manifest | ConvertTo-Json -Depth 5),[Text.UTF8Encoding]::new($false)); Write-Host 'Fertig. Vertix oeffnen und auf das Update unten links klicken.'; Write-Host 'Bei geoeffnetem Vertix erscheint das Update innerhalb von etwa 30 Sekunden.' } catch { Write-Host ('Fehler: '+$_.Exception.Message); exit 1 }"
if errorlevel 1 echo Updateeinrichtung fehlgeschlagen. Bitte die Fehlermeldung oben pruefen.
echo.
pause

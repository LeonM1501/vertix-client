# Vertix Client

Public update distribution for Vertix Client.

The test release 0.2.0 improves instance settings in the existing Vertix design, including a RAM slider and installation details.

Update metadata is published as `version.json`. Windows installers and corresponding GPL-3.0 source archives are stored under `releases/<version>/`.

Existing 0.1.0 builds have a legacy update endpoint. They need the one-time update configuration helper before they can discover releases from this repository. The helper changes only the per-user update configuration, not application files.

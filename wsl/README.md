1. [Install WSL](#install-wsl)

```powershell
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

2. [Download wsl2 Linux](https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi)

3. set wsl2 as default

```powershell
wsl --update
wsl --set-default-version 2
```

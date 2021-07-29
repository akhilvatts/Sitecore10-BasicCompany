# escape=`

ARG BASE_IMAGE

FROM ${BASE_IMAGE}

ARG ARTIFACT_PATH

ARG WDP_ARTIFACT_PATH

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

WORKDIR C:\inetpub\wwwroot

# Copy solution website files
COPY ${ARTIFACT_PATH} .

# find transform files and do transformation
RUN (Get-ChildItem -Path 'C:\\inetpub\\wwwroot\\Web.config.xdt' -Recurse ) | ForEach-Object { & 'C:\\tools\\scripts\\Invoke-XdtTransform.ps1' -Path 'C:\\inetpub\\wwwroot\\web.config' -XdtPath $_.FullName -XdtDllPath 'C:\\tools\\bin\\Microsoft.Web.XmlTransform.dll'; };
RUN (Get-ChildItem -Path 'C:\\inetpub\\wwwroot\\App_Config\\ConnectionStrings.config.xdt' -Recurse ) | ForEach-Object { & 'C:\\tools\\scripts\\Invoke-XdtTransform.ps1' -Path 'C:\\inetpub\\wwwroot\\App_Config\\ConnectionStrings.config' -XdtPath $_.FullName -XdtDllPath 'C:\\tools\\bin\\Microsoft.Web.XmlTransform.dll'; };

# Include TDS Item packages (2 options)

# OPTION 1: Allow TDS to install on startup, knowing this will be done on EVERY container create
COPY ${WDP_ARTIFACT_PATH} \temp\
RUN Get-ChildItem -Path 'C:\\temp\\*.wdp.zip' | % { Expand-Archive -Path $_.FullName -DestinationPath 'C:\\temp' -Force; }; `
    Move-Item -Path 'C:\\temp\\Content\\Website\\Bin\*' -Destination .\bin -Force; `
    Move-Item -Path 'C:\\temp\\Content\\Website\\temp\*' -Destination .\temp -Force; `
    Remove-Item -Path 'C:\\temp' -Recurse -Force; `
    # Ensure TDS has permissions to delete items after install
    cmd /C icacls .\temp\WebDeployItems /grant 'Everyone:(OI)(CI)M';

# OPTION 2: Invoke Deploy-TdsWdpPackages.ps1 on the container as-needed (similar to Unicorn sync) with the following script:
#   docker exec <cm container> powershell -command "C:\install\Deploy-TdsWdpPackages.ps1"
# COPY --from=tooling \tools\scripts\Deploy-TdsWdpPackages.ps1 \install\Deploy-TdsWdpPackages.ps1
# COPY --from=solution \artifacts\packages\ \install\packages\
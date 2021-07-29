# escape=`

ARG BASE_IMAGE

FROM ${BASE_IMAGE}

ARG ARTIFACT_PATH

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

WORKDIR C:\inetpub\wwwroot

# Copy solution website files
COPY  ${ARTIFACT_PATH} .

# find transform files and do transformation
RUN (Get-ChildItem -Path 'C:\\inetpub\\wwwroot\\Web.config.xdt' -Recurse ) | ForEach-Object { & 'C:\\tools\\scripts\\Invoke-XdtTransform.ps1' -Path 'C:\\inetpub\\wwwroot\\web.config' -XdtPath $_.FullName -XdtDllPath 'C:\\tools\\bin\\Microsoft.Web.XmlTransform.dll'; };